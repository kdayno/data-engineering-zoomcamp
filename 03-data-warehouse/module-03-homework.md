## Module 3 Homework

-  Question 1: What is count of records for the 2022 Green Taxi Data??
- Answer: 840,402

- Question 2: Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables. What is the estimated amount of data that will be read when this query is executed on the External Table and the Table?
- Answer: 0 MB for the External Table and 6.41MB for the Materialized Table

- Question 3: How many records have a fare_amount of 0?
- Answer: 1622

- Question 4: What is the best strategy to make an optimized table in Big Query if your query will always order the results by PUlocationID and filter based on lpep_pickup_datetime? (Create a new table with this strategy)
- Answer: Partition by lpep_pickup_datetime Cluster on PUlocationID
  - Reasoning: Partitioning splits data up by the partitioning condition provided. In this case, all data with the same lpep_pickup_datetime will be stored together in the same directory. While, clustering colocates related data based on a column provided. Order of the columns is important. The srder of the specified columns determines the sort order of the data.
    - Partitioning optimizes filtering
    - Clustering optimizes ordering

- Question 5: Write a query to retrieve the distinct PULocationID between lpep_pickup_datetime 06/01/2022 and 06/30/2022 (inclusive)
  - Use the materialized table you created earlier in your from clause and note the estimated bytes. Now change the table in the from clause to the partitioned table you created for question 4 and note the estimated bytes processed. What are these values?
  - Choose the answer which most closely matches.
- Answer: 12.82 MB for non-partitioned table and 1.12 MB for the partitioned table

- Question 6: Where is the data stored in the External Table you created?
- Answer: GCP Bucket

- Question 7: It is best practice in Big Query to always cluster your data?
- Answer: False
  - Reasoning: If the table is too small, clustering data will actually negatively impact the performance of your queries since there is additional metadata management overhead that incurred as a result without gaining any benefits of clustering.

- Question 8: Write a SELECT count(*) query FROM the materialized table you created. How many bytes does it estimate will be read? Why?
- Answer: Query will process 0 B when run.
  - Reasoning: The count of a materialized table is stored as metadata so it does not need to be processed each time.