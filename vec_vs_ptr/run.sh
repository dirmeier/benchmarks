#!/usr/bin/env bash

./build/vec_00 | awk 'BEGIN{OFS="\t"}{ print "O0", $0  }' > data/time.tsv
./build/vec_01 | awk 'BEGIN{OFS="\t"}{ print "O1", $0  }'>> data/time.tsv
./build/vec_02 | awk 'BEGIN{OFS="\t"}{ print "O2", $0  }'>> data/time.tsv

