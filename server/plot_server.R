#!/usr/bin/env Rscript

library(dplyr)
library(ggplot2)
library(ggthemr)
ggthemr("fresh", "scientific")

options(digits=2, stringsAsFactors=FALSE)

dat <- read.table("./data/time.txt", sep=" ", header=F, stringsAsFactors=FALSE)
colnames(dat) <- c("Server", "Task", "Percentage", "Times")
dat$Task[dat$Task == "Hello"] <- "Hello World"
dat$Percentage <- factor(paste0(dat$Percentage, "% of requests"),
                        levels=unique(paste0(dat$Percentage, "% of requests")))

ggplot(dat, aes(Server, log(Times), fill=Server)) +
  facet_grid(Percentage ~ Task) +
  geom_bar(stat="identity") +
  theme(axis.text.x=element_blank()) +
  geom_text(aes(x=Server, y=log(Times) + .5, label=paste0(Times, "ms")))
  xlab("Language") +
  ylab("Times")

ggsave(filename="./data/time.png", width=8, height=8)
