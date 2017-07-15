Spark map reduce benchmark
===========================

Simple benchmark between `Scala` and `Python` for Spark.

## Results

<div align="center">
<img src="https://github.com/dirmeier/benchmarks/blob/master/map_reduce/data/time.png" alt="Drawing" width="75%" />
</div>

## Usage

First build the package:

```sh
  cd scala/map/ && sbt package && cd ../../
```

Then test in different orders:

```sh

  for i in {1..5}
  do
    (time spark-submit --master "local[*]" --driver-memory 3G --executor-memory 6G python/map_filter_groupby_count.py) >> data/result.txt 2> >( sed '$!d' |  sed 's/^/python /' >> data/time.txt)
    
    (time spark-submit --master "local[*]" --driver-memory 3G --executor-memory 6G --class MapFilterGroupByCount scala/map/target/scala-2.11/map_2.11-1.0.jar) >> data/result.txt 2> >( sed '$!d' |  sed 's/^/scala /' >> data/time.txt)
    
    (time spark-submit --master "local[*]" --driver-memory 3G --executor-memory 6G --class MapFilterGroupByCount scala/map/target/scala-2.11/map_2.11-1.0.jar) >> data/result.txt 2> >( sed '$!d' |  sed 's/^/scala /' >> data/time.txt)
    
    (time spark-submit --master "local[*]" --driver-memory 3G --executor-memory 6G python/map_filter_groupby_count.py) >> data/result.txt 2> >( sed '$!d' |  sed 's/^/python /' >> data/time.txt)
  done
```

Then plot the results:

```sh
  ./plot_map_reduce.R
```
