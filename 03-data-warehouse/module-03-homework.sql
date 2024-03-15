-- Setup
CREATE OR REPLACE EXTERNAL TABLE ny_taxi.external_green_taxi_trips_2022 OPTIONS (
        format = 'PARQUET',
        uris = ['gs://bucket_mage_kdayno/nyc-green-trip-2022/green_tripdata_2022-*.parquet']
    );
-- Question 1
SELECT COUNT(*)
FROM ny_taxi.external_green_taxi_trips_2022;
-- Setup
CREATE OR REPLACE TABLE ny_taxi.green_taxi_trips_nonpartitioned AS
SELECT *
FROM ny_taxi.external_green_taxi_trips_2022;
-- Question 2
-- This query will process 6.41 MB when run.
-- Materialized table
SELECT COUNT (DISTINCT PULocationID)
FROM ny_taxi.green_taxi_trips_nonpartitioned;
-- External table
-- This query will process 0 B when run.
SELECT COUNT (DISTINCT PULocationID)
FROM ny_taxi.external_green_taxi_trips_2022;
-- Question 3
SELECT COUNT(*)
FROM ny_taxi.external_green_taxi_trips_2022
WHERE fare_amount = 0;
-- Question 4
CREATE OR REPLACE TABLE ny_taxi.green_taxi_trips_partitioned_clustered PARTITION BY DATE(lpep_pickup_datetime) CLUSTER BY PULocationID AS
SELECT *
FROM `ny_taxi.external_green_taxi_trips_2022`;
-- Question 5
-- Materialized Table
-- This query will process 12.82 MB when run.
SELECT DISTINCT (PULocationID)
FROM `ny_taxi.green_taxi_trips_nonpartitioned`
WHERE lpep_pickup_datetime BETWEEN '2022-06-01' AND '2022-06-30' -- Optimzied table via Partitioning and Clustering
    -- This query will process 1.12 MB when run.
SELECT DISTINCT (PULocationID)
FROM `ny_taxi.green_taxi_trips_partitioned_clustered`
WHERE lpep_pickup_datetime BETWEEN '2022-06-01' AND '2022-06-30'
SELECT COUNT(*) -- Question 8
FROM `ny_taxi.green_taxi_trips_nonpartitioned`;