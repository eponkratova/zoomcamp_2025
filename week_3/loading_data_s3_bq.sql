-- Getting the rowcount for the num of rows
select count(*) from  `zoomcamp.external_yellow_tripdata_non_partitoned` 

-- Getting distinct count
select count(distinct PULocationID ) from  `zoomcamp.external_yellow_tripdata_non_partitoned` 

-- Getting fare amount records
select count( PULocationID ) from  `zoomcamp.external_yellow_tripdata_non_partitoned` 
where fare_amount = 0

-- Experimenting with partitions
select * from  `zoomcamp.external_yellow_tripdata_non_partitoned` 