import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.functions.{col, rand, lit, concat, explode, array}


object a02_skew_problem extends App {

  println("creating SparkSession Object")
  val spark = SparkSession.builder.master("local[*]").appName("repartition_vs_coalesce_app").getOrCreate()
  spark.sparkContext.setLogLevel("ERROR")
  import spark.implicits._

  println("creating skew df")
  val skewData = (0 until 100000).map(i => ("A", i)) ++ Seq(("B", 1), ("C", 1), ("D", 1))
  val skewDf = skewData.toDF("key", "value")

  println("creating lookup df")
  val lookupData = Seq(
    ("A", "alpha"),
    ("B", "beta"),
    ("C", "gamma"),
    ("D", "delta")
  )
  val lookupDf = lookupData.toDF("key", "label")
  
  println("normal join")
  skewDf.join(lookupDf, skewDf("key")===lookupDf("key"), "inner").groupBy(col("label")).count().show()


  println("creating salt df")
  val saltedDf = skewDf.withColumn("salted_key", concat(col("key"), lit("_"), (rand() * 11).cast("int")))

  println("Creating the salted key for lookup table")
  val expandedLookupDf = lookupDf.withColumn(
    "salted_key",
    explode(array((0 until 11).map(i => concat(col("key"), lit("_"), lit(i))): _*))
  )

  println("join after salting")
  saltedDf.join(expandedLookupDf, "salted_key", "inner").groupBy(col("label")).count().show()
}
