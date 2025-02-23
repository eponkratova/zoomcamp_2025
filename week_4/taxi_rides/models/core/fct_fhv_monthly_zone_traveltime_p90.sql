{{
    config(
        materialized='table'
    )
}}

with dim_vhv_trips as 
(select *,
TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, SECOND) AS trip_duration
from {{ ref('dim_fhv_trips') }})
SELECT 
  pickup_year,
  pickup_month,
  pickup_borough,
  pickup_zone,
  dropoff_borough,
  dropoff_zone,
  APPROX_QUANTILES(trip_duration, 100)[OFFSET(89)] AS p90_trip_duration
FROM dim_vhv_trips
GROUP BY 
  pickup_year,
  pickup_month,
  pickup_borough,
  pickup_zone,
  dropoff_borough,
  dropoff_zone
ORDER BY 
  pickup_year, pickup_month,   pickup_borough,
  pickup_zone,
  dropoff_borough,
  dropoff_zone

