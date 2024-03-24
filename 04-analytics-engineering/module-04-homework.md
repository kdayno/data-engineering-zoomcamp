## Module 04: Analyitcs Engineering - Homework

### Data Setup
CREATE TABLE data-eng-zoomcamp-2024-412913.dbt_demo_kd.green_taxi_trips AS 
SELECT * FROM bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2019
UNION ALL
SELECT * FROM bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2020

CREATE TABLE data-eng-zoomcamp-2024-412913.dbt_demo_kd.yellow_taxi_trips AS 
SELECT * FROM bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2019
UNION ALL
SELECT * FROM bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2020