CREATE TABLE  `clear-destiny-447905-r3.trips_data_all.green_tripdata` as
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2019`
union all
select * from `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2020`



CREATE TABLE  `clear-destiny-447905-r3.trips_data_all.yellow_tripdata` as
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2019`
union all
select * from `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2020`


ALTER TABLE `trips_data_all.yellow_tripdata`
  RENAME COLUMN vendor_id TO VendorID;
ALTER TABLE `trips_data_all.yellow_tripdata`
  RENAME COLUMN pickup_datetime TO tpep_pickup_datetime;
ALTER TABLE `trips_data_all.yellow_tripdata`
  RENAME COLUMN dropoff_datetime TO tpep_dropoff_datetime;
ALTER TABLE `trips_data_all.yellow_tripdata`
  RENAME COLUMN rate_code TO RatecodeID;
ALTER TABLE `trips_data_all.yellow_tripdata`
  RENAME COLUMN imp_surcharge TO improvement_surcharge;
ALTER TABLE `trips_data_all.yellow_tripdata`
  RENAME COLUMN pickup_location_id TO PULocationID;
ALTER TABLE `trips_data_all.yellow_tripdata`
  RENAME COLUMN dropoff_location_id TO DOLocationID;


CREATE OR REPLACE EXTERNAL TABLE `clear-destiny-447905-r3.trips_data_all.fhv_tripdata`
OPTIONS (
  format = 'CSV',
  uris = ['gs://week_4_zoom/fhv_tripdata_2019-*.csv']
);
