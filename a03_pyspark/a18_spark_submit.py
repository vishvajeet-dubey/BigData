from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("testing_spark_Submit").master("local[5]").getOrCreate()

class Main:
    def __init__(self):
        print("********** Main class initialized **********")

    def spark_submit(self):
        # spark-submit command
        """
        spark-submit --master local[2] --driver-memory 1g --executor-memory 1g --num-executors 2 --executor-cores 2 D:\gitnote\a08-Data-Engg\a03_Spark_Practical\a13_spark_submit.py testing_spark_Submit
        """

        customer_data = [
            (1, 'manish', 'patna', '30-05-2022'),
            (2, 'vikash', 'kolkata', '12-03-2023'),
            (3, 'nikita', 'delhi', '25-06-2023'),
            (4, 'rahul', 'ranchi', '24-03-2023'),
            (5, 'mahesh', 'jaipur', '22-03-2023'),
            (6, 'prantosh', 'kolkata', '18-10-2022'),
            (7, 'raman', 'patna', '30-12-2022'),
            (8, 'prakash', 'ranchi', '24-02-2023'),
            (9, 'ragini', 'kolkata', '03-03-2023'),
            (10, 'raushan', 'jaipur', '05-02-2023')
        ]
        customer_schema = ['customer_id', 'custmer_name', 'address',    'date_of_joining']

        print("******** creating the customer_dataframe *********")
        customer_df = spark.createDataFrame(data=customer_data,     schema=customer_schema)

        return customer_df

if __name__=="__main__":
    app = Main()
    app.spark_submit().show()
    spark.stop()