import org.apache.spark.sql.SparkSession
import org.apache.spark.ml.feature.VectorAssembler
import org.apache.spark.ml.linalg.Vectors
import org.apache.spark.ml.clustering.KMeans

object Clustering
{
  def main(args: Array[String])
  {
    val file = "/Users/simondi/PHD/data/data/target_infect_x/screening_data_subset/cells_sample_10_100lines.tsv"
    val spark = SparkSession
      .builder()
      .appName("kmeans")
      .getOrCreate()

    var df = spark.read.format("com.databricks.spark.csv")
      .option("sep", "\t").csv(file)

    val colnames = df.columns
    for (c <- colnames)
    {
      df = df.withColumnRenamed(c, c.replace(".", "_"))
    }


    for (c <- colnames)
    {
      if (c.startsWith("cells"))
      {
        df = df.withColumn(c, df.col(c).cast("double"))
      }
    }
    df = df.na.fill(0.0)

    var feature_columns = List[String]()
    for (c <- df.columns)
    {
      if (c.startsWith("cells")) feature_columns.++(c)
    }


    val assembler = new VectorAssembler()
      .setInputCols(feature_columns.toArray)
      .setOutputCol("features")
    val data = assembler.transform(df)

    val km = new KMeans().setK(2).setSeed(23)
    val model = km.fit(data)

    println("\n\nCluster Centers: ")
    model.clusterCenters.foreach(println)
    println("\n\n")

  }
}
