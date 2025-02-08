-- Getting the rowcount for the num of rows
select count(*) from  `zoomcamp.external_yellow_tripdata_non_partitoned` 

-- Getting distinct count
select count(distinct PULocationID ) from  `zoomcamp.external_yellow_tripdata_non_partitoned` 

-- Getting fare amount records
select count( PULocationID ) from  `zoomcamp.external_yellow_tripdata_non_partitoned` 
where fare_amount = 0

--Checking size
select PULocationID  from  `zoomcamp.external_yellow_tripdata_non_partitoned` 
select PULocationID, DOLocationID  from  `zoomcamp.external_yellow_tripdata_non_partitoned` 

-- Working with filters
select distinct VendorID from `zoomcamp.external_yellow_tripdata_non_partitoned` 
where date(tpep_dropoff_datetime)>='2024-03-01' and date(tpep_dropoff_datetime)<='2024-03-15'

-- Materializing table
CREATE OR REPLACE TABLE `zoomcamp.external_yellow_tripdata_non_partitoned_query`  AS
select distinct VendorID from `zoomcamp.external_yellow_tripdata_non_partitoned` 
where date(tpep_dropoff_datetime)>='2024-03-01' and date(tpep_dropoff_datetime)<='2024-03-15'

--Creating partitioned table
CREATE OR REPLACE TABLE `zoomcamp.external_yellow_tripdata_partitoned_query`
PARTITION BY
  DATE(tpep_dropoff_datetime) AS
SELECT * FROM `zoomcamp.external_yellow_tripdata_non_partitoned`

SELECT distinct VendorID FROM`zoomcamp.external_yellow_tripdata_partitoned_query`
where date(tpep_dropoff_datetime)>='2024-03-01' and date(tpep_dropoff_datetime)<='2024-03-15'