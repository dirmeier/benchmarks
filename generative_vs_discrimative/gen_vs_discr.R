#!/usr/bin/env Rscript

library(mlr)
library(tidyr)
library(dplyr)
library(data.table)
library(ggplot2)
library(ggthemr)
library(hrbrthemes)
ggthemr("fresh", "scientific")
import_roboto_condensed()

set <- fread("ftp://ftp.cs.wisc.edu/math-prog/cpo-dataset/machine-learn/cancer/WDBC/WDBC.dat") %>%
  select(-V1) %>%
  rename(Outcome=V2)
colnames(set)[-1] <- paste0("X", seq(colnames(set)[-1]))

set <- as.data.frame(set)
set$y <- 0
set$y[set$Outcome == "B"] <- 1
set$Outcome <- NULL

task      <- makeClassifTask(data = set, target = "y")
bayes.lrn <- makeLearner("classif.naiveBayes")
logit.lrn <- makeLearner("classif.svm")

performace <- do.call("rbind", lapply(seq(25, 50, by=10), function(i)
{
  curr.set  <- set[1:i,]
  set.seed(1)
  idxs <- sample(seq(nrow(curr.set)))
  cv.l <- NULL
  for (cv in idxs)
  {
    train.set <- which(idxs != cv)
    test.set  <- which(idxs == cv)

    bayes.model <- train(bayes.lrn, task, subset = train.set)
    logit.model <- train(logit.lrn, task, subset = train.set)

    bayes.pred <- predict(bayes.model, task = task, subset = test.set)
    logit.pred <- predict(logit.model, task = task, subset = test.set)
    bayes.performe <- performance(bayes.pred, measures = list(mmce, acc))
    logit.performe <- performance(logit.pred, measures = list(mmce, acc))

    cv.l <- rbind(cv.l, list(I=i, CV=cv, NaiveBayes=bayes.performe[2], SVM=logit.performe[2]))
  }
  as.data.frame(cv.l) %>%
    dplyr::summarize(
      I=mean(as.numeric(I)),
      NaiveBayes=mean(as.numeric(NaiveBayes)),
      SVM=mean(as.numeric(SVM)))
}))

per <- as.data.frame(performace)
per.ga <- gather(per, Model, Accuracy, -I)
per.ga$I <- as.factor(unlist(per.ga$I))
per.ga$Accuracy<- as.numeric(unlist(per.ga$Accuracy))
per.ga$Model <- factor(unlist(per.ga$Model))

ggplot(per.ga, aes(x=I, y=Accuracy,fill=Model)) +
  hrbrthemes::theme_ipsum_rc() +
  geom_bar(stat="identity",position=position_dodge()) +
  xlab("Number of observations")

