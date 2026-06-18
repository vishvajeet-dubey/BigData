import org.apache.spark.sql.SparkSession
//import org.apache.spark.sql.functions.col
import org.apache.spark.sql.types.{StructType, StringType, StructField, DoubleType}

object a01_repartition_vs_coalesce extends App {
  val spark = SparkSession.builder.master("local[*]").appName("repartition_vs_coalesce_app").getOrCreate()
  spark.sparkContext.setLogLevel("ERROR")

  val dfSchema = StructType(Array(
      StructField("longitude", DoubleType, nullable = false),
      StructField("latitude", DoubleType, nullable = false),
      StructField("housing_median_age", DoubleType, nullable = false),
      StructField("total_rooms", DoubleType, nullable = false),
      StructField("total_bedrooms", DoubleType, nullable = false),
      StructField("population", DoubleType, nullable = false),
      StructField("households", DoubleType, nullable = false),
      StructField("median_income", DoubleType, nullable = false),
      StructField("median_house_value", DoubleType, nullable = false),
      StructField("ocean_proximity", StringType, nullable = false)
  ))

  val df = spark.read.format("csv")
    .option("header", "true")
    .option("inferSchema", "false")
    .load("src/main/resources/airbnb.csv")

  println(f"No of partition before repartition = ${df.rdd.getNumPartitions}")

  val df1 = df.repartition(5)
  println(f"No of partition after repartition = ${df1.rdd.getNumPartitions}")

  val df2 = df1.coalesce(2)
  println(s"No of partition after coalesce = ${df2.rdd.getNumPartitions}")
}
