{{
    config(
        materialized='table'
    )
}}

with fhv_tripdata as (
    select *
    from  {{ source('staging','fhv_tripdata') }}
    where dispatching_base_num is not null
), 
dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select ft.*,
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone,
    EXTRACT(YEAR FROM pickup_datetime) AS pickup_year,
    EXTRACT(month FROM pickup_datetime) AS pickup_month,
    EXTRACT(quarter FROM pickup_datetime) AS pickup_quarter,
    concat(EXTRACT(YEAR FROM pickup_datetime),'-',EXTRACT(quarter FROM pickup_datetime)) as pickup_yyyy_qq
from fhv_tripdata ft 
inner join dim_zones as pickup_zone
on ft.PUlocationID = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on ft.DOlocationID = dropoff_zone.locationid