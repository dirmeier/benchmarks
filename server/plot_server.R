#!/usr/bin/env Rscript

library(dplyr)
library(ggplot2)
library(ggthemr)
ggthemr("fresh", "scientific")

options(digits=2)

dat <- read.table("./data/time.txt", sep=" ", header=F)
colnames(dat) <- c("Server", "Task", "Percentage", "Times")

means <- dat %>% group_by(Server, Task) %>%
  dplyr::summarize(LogMean=log(mean(Times)),
                   Mean=mean(Times)) %>%
  dplyr::group_by(Server, Task)
dat <- dplyr::left_join(dat, means)

ggplot(dat, aes(Server, log(Times), fill=Server)) +
  facet_grid(. ~ Task) +
  geom_boxplot() +
  theme(axis.text.x=element_blank()) +
  xlab("Language") +
  ylab("Times")


ggsave(filename="./data/time.png", width=8, height=8)
