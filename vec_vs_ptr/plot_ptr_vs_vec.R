#!/usr/bin/env Rscript

library(dplyr)
library(readr)
library(ggplot2)
library(ggthemr)
library(hrbrthemes)
ggthemr("fresh", "scientific")
hrbrthemes::import_roboto_condensed()

dat <- read_tsv("./data/time.tsv", col_names=F) %>%
  transmute(Optimization = factor(X1),
            ArrayLength = factor(X2, levels=unique(X2)),
            Class = as.character(X3),
            Times = as.numeric(as.character(X4))) %>%
  dplyr::filter(Optimization == "O2")
dat$Times <- dat$Times + 1
dat$Type <- "Vector"
dat$Type[dat$Class == "ptr w/o alloc" |
           dat$Class == "ptr with alloc" ] <- "Pointer"
dat$MeasuredAllocation <- "No"
dat$MeasuredAllocation[dat$Class == "vec with alloc" |
                         dat$Class == "ptr with alloc" ] <- "Yes"

ggplot(dat, aes(ArrayLength, Times, fill=Type, color=MeasuredAllocation)) +
  facet_grid(MeasuredAllocation ~ ., scales="free") +
  scale_color_manual("Timing includes\nobject allocation",
                     values=c("black", "black")) +
  geom_boxplot() +
  scale_y_log10() +
  hrbrthemes::theme_ipsum_rc() +
  xlab("Arraylength") +
  ylab("log10(Time) in microseconds") +
  coord_flip() +
  labs(title="Timing benchmark of vectors vs pointers",
       subtitle="Benchmarking if it is faster to create, access and fill vectors or pointers for different array lengths")


ggsave(filename="./data/time.png", width=8, height=8)
