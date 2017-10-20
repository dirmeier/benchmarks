library(mlr)
library(ggplot2)
library(tidyr)

set.seed(23)
 n <- 1000
 p <- 500
 X <- matrix(rnorm(n*p), n)
 b <- rnorm(p, 0, 1)
 z <- 1 + X %*% b
 pr <- 1 / (1 + exp(-z))
 y <- rbinom(n, 1, pr)

set <- data.frame(y=y, X=X)

task      <- makeClassifTask(data = set, target = "y")
bayes.lrn <- makeLearner("classif.naiveBayes")
logit.lrn <- makeLearner("classif.svm")


performace <- do.call("rbind", lapply(seq(500, 800, by=10), function(i)
{
  curr.set  <- set[1:i,]
  idxs <- sample(rep(1:10, length.out=nrow(curr.set)))
  cv.l <- NULL
  for (cv in seq(10))
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
  cv.l
}))

per <- as.data.frame(performace)
per.ga <- gather(per, Model, Accuracy, -I, -CV)
per.ga$I <- as.factor(unlist(per.ga$I))
per.ga$Accuracy<- as.numeric(unlist(per.ga$Accuracy))
per.ga$Model <- factor(unlist(per.ga$Model))
per.ga$CV <- as.integer(unlist(per.ga$CV))
ggplot(per.ga, aes(I, Accuracy,color=Model)) + geom_boxplot()

