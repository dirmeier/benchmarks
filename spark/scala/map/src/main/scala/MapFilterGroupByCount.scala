import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf

object MapFilterGroupByCount
{
  def main(args: Array[String])
  {
    val file = "/Users/simondi/PHD/data/data/target_infect_x/screening_data_subset/cells_sample_10.tsv"
    val conf = new SparkConf().setAppName("filter")
    val sc = new SparkContext(conf)
    val df = sc.textFile(file)
    val gr = df.map(_.split("\t"))
           .filter(x => x(1) == "salmonella")
           .groupBy(x => x(8))
           .count()
    println("\n\nResult:"+ gr + "\n\n")
    sc.stop()
  }
}
