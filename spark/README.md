Spark language benchmark
========================

Simple benchmark between `Scala` and `Python` for Spark.

## Results

<div align="center">
<img src="https://github.com/dirmeier/benchmarks/blob/master/spark/data/time.png" alt="Drawing" width="75%" />
</div>

## Usage

For testing simple pyspark RDD tasks:

```sh
  (time spark-submit --master "local[*]" --driver-memory 3G --executor-memory 6G map_filter_groupby_count.py) >> result.txt 2>> time.txt
```
For testing the same with scala:

```sh
  sbt package
  (time spark-submit --master "local[*]" --driver-memory 3G --executor-memory 6G --class MapFilterGroupByCount benchmark_2.11-1.0.jar) >> result.txt 2>> time.txt
```

For testing clustering with pyspark's DataFrame API:

```sh
  (time spark-submit --master "local[*]" --driver-memory 3G --executor-memory 6G kmeans.py) >> result.txt 2>> time.txt
```

For testing the same with scala:

```sh
  sbt package
  (time spark-submit --master "local[*]" --driver-memory 3G --executor-memory 6G --class Kmeans benchmark_2.11-1.0.jar) >> result.txt 2>> time.txt
```
