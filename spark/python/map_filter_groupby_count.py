import os
import sys
import pandas

import numpy

import findspark
findspark.init("/usr/local/spark/spark")

import pyspark

from pyspark.sql.window import Window
import pyspark.sql.functions as func

from pyspark.rdd import reduce
from pyspark.sql.types import DoubleType
from pyspark.ml.feature import VectorAssembler
from pyspark.ml.clustering import BisectingKMeans
from pyspark.ml.linalg import SparseVector, VectorUDT, Vector, Vectors

conf = pyspark.SparkConf()
sc = pyspark.SparkContext(conf=conf)

file_name = "/Users/simondi/PHD/data/data/target_infect_x/screening_data_subset/cells_sample_10.tsv"
df = sc.textFile(file_name)
gr = df.map(lambda x: x.split("\t")) \
       .filter(lambda x: x[1] == "salmonella") \
       .groupBy(lambda x: x[8]) \
       .count()

print("\n\nResult is " + str(gr) + "\n\n")

sc.stop()
