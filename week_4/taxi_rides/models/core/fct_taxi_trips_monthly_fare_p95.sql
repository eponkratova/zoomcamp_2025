{{
    config(
        materialized='table'
    )
}}
WITH taxi_raw as 
(select * 
from {{ ref('fact_trips') }}
where payment_type_description in ('Cash', 'Credit Card')
and fare_amount > 0 and trip_distance > 0
and pickup_year=2020 and pickup_month=4 ) 
SELECT distinct
  service_type,
  EXTRACT(YEAR FROM pickup_datetime) AS year,
  EXTRACT(MONTH FROM pickup_datetime) AS month,
  PERCENTILE_CONT(fare_amount, 0.97) OVER (
    PARTITION BY service_type, EXTRACT(YEAR FROM pickup_datetime), EXTRACT(MONTH FROM pickup_datetime)
  ) AS p97,
  PERCENTILE_CONT(fare_amount, 0.95) OVER (
    PARTITION BY service_type, EXTRACT(YEAR FROM pickup_datetime), EXTRACT(MONTH FROM pickup_datetime)
  ) AS p95,
  PERCENTILE_CONT(fare_amount, 0.90) OVER (
    PARTITION BY service_type, EXTRACT(YEAR FROM pickup_datetime), EXTRACT(MONTH FROM pickup_datetime)
  ) AS p90
FROM taxi_raw
GROUP BY service_type, year, month, pickup_datetime, fare_amount