import pyspark
from pyspark.sql import SparkSession
from pyspark.sql import functions as F

spark = SparkSession.builder \
    .master("local[*]") \
    .appName('test') \
    .getOrCreate()

!wget https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-10.parquet

df = spark.read \
    .option("header", "true") \
    .parquet('yellow_tripdata_2024-10.parquet')

df.show()

df = df.repartition(4)

df.printSchema()

df \
    .withColumn('tpep_pickup_datetime', F.to_date(df.tpep_pickup_datetime)) \
    .select('tpep_pickup_datetime', 'VendorID') \
    .groupBy('tpep_pickup_datetime').count() \
    .show()

df.registerTempTable('trip_data')

spark.sql("""SELECT count(*) FROM trip_data where date(tpep_pickup_datetime)='2024-10-15'""").show()

spark.sql("""SELECT (tpep_dropoff_datetime-tpep_pickup_datetime) FROM trip_data order by (tpep_dropoff_datetime-tpep_pickup_datetime)  desc limit 2""").show()

spark.sql("""SELECT (unix_timestamp(tpep_dropoff_datetime) - unix_timestamp(tpep_pickup_datetime)) / 3600  FROM trip_data order by (unix_timestamp(tpep_dropoff_datetime) - unix_timestamp(tpep_pickup_datetime)) / 3600 desc limit 2""").show()

!wget wget https://d37ci6vzurychx.cloudfront.net/misc/taxi_zone_lookup.csv

df1 = spark.read \
    .option("header", "true") \
    .csv('taxi_zone_lookup.csv')

df1.registerTempTable('zone_data')

df_join = df.join(df1, df.PULocationID==df1.LocationID)

df_join.registerTempTable('joined')

spark.sql("""SELECT Zone, count(*) FROM joined group by Zone order by count(*) limit 2""").show()
