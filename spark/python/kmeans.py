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
from pyspark.ml.clustering import KMeans
from pyspark.ml.linalg import SparseVector, VectorUDT, Vector, Vectors

conf = pyspark.SparkConf()
sc = pyspark.SparkContext(conf=conf)
spark = pyspark.sql.SparkSession(sc)

file_name = "/Users/simondi/PHD/data/data/target_infect_x/screening_data_subset/cells_sample_10_100lines.tsv"
df = spark.read.csv(path=file_name, sep="\t", header='true')
old_cols = df.schema.names
new_cols = list(map(lambda x: x.replace(".", "_"), old_cols))

df = reduce(
  lambda data, idx: data.withColumnRenamed(old_cols[idx], new_cols[idx]),
  range(len(new_cols)), df)

for i, x in enumerate(new_cols):
    if x.startswith("cells"):
        df = df.withColumn(x, df[x].cast("double"))

df = df.fillna(0)

feature_columns = [x for x in df.columns if x.startswith("cells")]
assembler = VectorAssembler(inputCols=feature_columns,outputCol='features')
data = assembler.transform(df)

km = KMeans().setK(5).setSeed(23)
model = km.fit(data)

print("Cluster Centers: ")
centers = model.clusterCenters()
with open("test.loggg") as fh:
    for center in centers:
        fh.write(center)
        fh.write("\n")
spark.stop()
