#!/usr/bin/env Rscript

library(dplyr)
library(ggplot2)
library(ggthemr)
ggthemr("fresh", "scientific")


dat <- read.delim("./data/time.txt", sep=" ", header=F) %>%
  transmute(Language = sub("./", "", V1),
            Times = as.numeric(as.character(sub("s", "", V8))))

ggplot(dat, aes(Language, Times, fill=Language)) +
  geom_boxplot() +
  geom_jitter(width = 0.2, colour=1) +
  xlab("Language") +
  ylab("Times")

ggsave(filename="./data/time.png", width=8, height=8)
