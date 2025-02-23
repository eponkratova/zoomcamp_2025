{{
    config(
        materialized='table'
    )
}}

WITH taxi_raw as 
(select * 
from {{ ref('fact_trips') }}),
 taxi_raw_g_q1_2019 AS (
  SELECT 
    SUM(total_amount) AS revenue_g_q1_19,
    pickup_quarter,
    pickup_year,
    service_type,
    pickup_yyyy_qq
  FROM taxi_raw
  WHERE pickup_yyyy_qq IN ('2019-1')
    AND service_type = 'Green'
  GROUP BY 
    service_type,
    pickup_yyyy_qq,
    pickup_quarter,
    pickup_year
),
taxi_raw_g_q1_2020 AS (
  SELECT 
    SUM(total_amount) AS revenue_g_q1_20,
    pickup_quarter,
    pickup_year,
    service_type,
    pickup_yyyy_qq
  FROM taxi_raw
  WHERE pickup_yyyy_qq IN ('2020-1')
    AND service_type = 'Green'
  GROUP BY 
    service_type,
    pickup_yyyy_qq,
    pickup_quarter,
    pickup_year
),
taxi_g_q1_2020 AS (
  SELECT 
    (revenue_g_q1_20 / revenue_g_q1_19) * 100.0 AS rev_g_q1
  FROM taxi_raw_g_q1_2019, taxi_raw_g_q1_2020
),
taxi_raw_y_q1_2019 AS (
  SELECT 
    SUM(total_amount) AS revenue_y_q1_19,
    pickup_quarter,
    pickup_year,
    service_type,
    pickup_yyyy_qq
  FROM taxi_raw
  WHERE pickup_yyyy_qq IN ('2019-1')
    AND service_type = 'Yellow'
  GROUP BY 
    service_type,
    pickup_yyyy_qq,
    pickup_quarter,
    pickup_year
),
taxi_raw_y_q1_2020 AS (
  SELECT 
    SUM(total_amount) AS revenue_y_q1_20,
    pickup_quarter,
    pickup_year,
    service_type,
    pickup_yyyy_qq
  FROM taxi_raw
  WHERE pickup_yyyy_qq IN ('2020-1')
    AND service_type = 'Yellow'
  GROUP BY 
    service_type,
    pickup_yyyy_qq,
    pickup_quarter,
    pickup_year
),
taxi_y_q1_2020 AS (
  SELECT 
    (revenue_y_q1_20 / revenue_y_q1_19) * 100.0 AS rev_y_q1
  FROM taxi_raw_y_q1_2019, taxi_raw_y_q1_2020
),
taxi_raw_g_q2_2019 AS (
  SELECT 
    SUM(total_amount) AS revenue_g_q2_19,
    pickup_quarter,
    pickup_year,
    service_type,
    pickup_yyyy_qq
  FROM taxi_raw
  WHERE pickup_yyyy_qq IN ('2019-2')
    AND service_type = 'Green'
  GROUP BY 
    service_type,
    pickup_yyyy_qq,
    pickup_quarter,
    pickup_year
),
taxi_raw_g_q2_2020 AS (
  SELECT 
    SUM(total_amount) AS revenue_g_q2_20,
    pickup_quarter,
    pickup_year,
    service_type,
    pickup_yyyy_qq
  FROM `trips_data_all.fact_trips`
  WHERE pickup_yyyy_qq IN ('2020-2')
    AND service_type = 'Green'
  GROUP BY 
    service_type,
    pickup_yyyy_qq,
    pickup_quarter,
    pickup_year
),
taxi_g_q2_2020 AS (
  SELECT 
    (revenue_g_q2_20 / revenue_g_q2_19) * 100.0 AS rev_g_q2
  FROM taxi_raw_g_q2_2019, taxi_raw_g_q2_2020
),
taxi_raw_y_q2_2019 AS (
  SELECT 
    SUM(total_amount) AS revenue_y_q2_19,
    pickup_quarter,
    pickup_year,
    service_type,
    pickup_yyyy_qq
  FROM taxi_raw
  WHERE pickup_yyyy_qq IN ('2019-2')
    AND service_type = 'Yellow'
  GROUP BY 
    service_type,
    pickup_yyyy_qq,
    pickup_quarter,
    pickup_year
),
taxi_raw_y_q2_2020 AS (
  SELECT 
    SUM(total_amount) AS revenue_y_q2_20,
    pickup_quarter,
    pickup_year,
    service_type,
    pickup_yyyy_qq
  FROM v
  WHERE pickup_yyyy_qq IN ('2020-2')
    AND service_type = 'Yellow'
  GROUP BY 
    service_type,
    pickup_yyyy_qq,
    pickup_quarter,
    pickup_year
),
taxi_y_q2_2020 AS (
  SELECT 
    (revenue_y_q2_20 / revenue_y_q2_19) * 100.0 AS rev_y_q2
  FROM taxi_raw_y_q2_2019, taxi_raw_y_q2_2020
),
taxi_raw_g_q4_2019 AS (
  SELECT 
    SUM(total_amount) AS revenue_g_q4_19,
    pickup_quarter,
    pickup_year,
    service_type,
    pickup_yyyy_qq
  FROM taxi_raw
  WHERE pickup_yyyy_qq IN ('2019-4')
    AND service_type = 'Green'
  GROUP BY 
    service_type,
    pickup_yyyy_qq,
    pickup_quarter,
    pickup_year
),
taxi_raw_g_q4_2020 AS (
  SELECT 
    SUM(total_amount) AS revenue_g_q4_20,
    pickup_quarter,
    pickup_year,
    service_type,
    pickup_yyyy_qq
  FROM taxi_raw
  WHERE pickup_yyyy_qq IN ('2020-4')
    AND service_type = 'Green'
  GROUP BY 
    service_type,
    pickup_yyyy_qq,
    pickup_quarter,
    pickup_year
),
taxi_g_q4_2020 AS (
  SELECT 
    (revenue_g_q4_20 / revenue_g_q4_19) * 100.0 AS rev_g_q4
  FROM taxi_raw_g_q4_2019, taxi_raw_g_q4_2020
),
taxi_raw_y_q4_2019 AS (
  SELECT 
    SUM(total_amount) AS revenue_y_q4_19,
    pickup_quarter,
    pickup_year,
    service_type,
    pickup_yyyy_qq
  FROM taxi_raw
  WHERE pickup_yyyy_qq IN ('2019-4')
    AND service_type = 'Yellow'
  GROUP BY 
    service_type,
    pickup_yyyy_qq,
    pickup_quarter,
    pickup_year
),
taxi_raw_y_q4_2020 AS (
  SELECT 
    SUM(total_amount) AS revenue_y_q4_20,
    pickup_quarter,
    pickup_year,
    service_type,
    pickup_yyyy_qq
  FROM taxi_raw
  WHERE pickup_yyyy_qq IN ('2020-4')
    AND service_type = 'Yellow'
  GROUP BY 
    service_type,
    pickup_yyyy_qq,
    pickup_quarter,
    pickup_year
),
taxi_y_q4_2020 AS (
  SELECT 
    (revenue_y_q4_20 / revenue_y_q4_19) * 100.0 AS rev_y_q4
  FROM taxi_raw_y_q4_2019, taxi_raw_y_q4_2020
)
SELECT *
FROM taxi_y_q1_2020, 
     taxi_y_q2_2020, 
     taxi_y_q4_2020,  
     taxi_g_q1_2020,
     taxi_g_q2_2020, 
     taxi_g_q4_2020