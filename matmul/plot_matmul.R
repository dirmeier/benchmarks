#!/usr/bin/env Rscript

library(dplyr)
library(ggplot2)
library(ggthemr)
ggthemr("fresh", "scientific")

dat <- read.delim("./matmul/time.txt", sep=" ", header=F) %>%
  transmute(Language = sub("./", "", V1),
            Times = as.numeric(as.character(sub("s", "", V3))))
dat$Language <- factor(dat$Language, levels = dat[order(dat$Times), 1])

ggplot(dat, aes(Language, Times, fill=Language)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=Times), vjust=-.25) +
  xlab("Language") +
  ylab("Times")

ggsave(filename="./time.svg", device="svg")
