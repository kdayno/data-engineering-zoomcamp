## Module 1 Homework

### Question 1. Knowing docker tags
- Answer: --rm

### Question 2. Understanding docker first run
- Answer: 0.42.0
- Output: 
    `root@3b43c96181a0:/# pip list`
    `Package    Version`
    `---------- -------`
    `pip        23.0.1`
    `setuptools 58.1.0`
    `wheel      0.42.0`

### Question 3. Count records
- Answer: 15612
- Query:
    `SELECT COUNT(*)`
    `FROM green_taxi_trips`
    `WHERE CAST(lpep_pickup_datetime AS date) = DATE '2019-09-18'`
	    `AND CAST(lpep_dropoff_datetime AS date) = DATE '2019-09-18';`

### Question 4. Longest trip for each day
- Answer: 2019-09-26
- Query:
    `SELECT CAST(lpep_pickup_datetime AS date), MAX(trip_distance) AS trip_distance`
    `FROM green_taxi_trips`
    `GROUP BY lpep_pickup_datetime`
    `ORDER BY trip_distance DESC`
    `LIMIT 1`


### Question 5. Three biggest pick up Boroughs
- Answer: "Brooklyn" "Manhattan" "Queens"
- Query:
    `SELECT puz."Borough", SUM(total_amount)`
    `FROM green_taxi_trips gt`
    `INNER JOIN zones2 puz ON gt."PULocationID" = puz."LocationID"`
    `WHERE CAST(gt.lpep_pickup_datetime AS DATE) = DATE '2019-09-18'`
        `AND puz."Borough" != 'Unknown' `
    `GROUP BY puz."Borough"`
    `HAVING SUM(total_amount) > 50000`
    `ORDER BY sum DESC `


### Question 6. Largest tip
- Answer: JFK Airport
- Query:
    `SELECT doz."Zone" AS dropoff_zone, MAX(tip_amount) AS max_tip`
    `FROM green_taxi_trips gt`
    `INNER JOIN zones2 poz ON gt."PULocationID" = poz."LocationID"`
    `INNER JOIN zones2 doz ON gt."DOLocationID" = doz."LocationID"`
    `WHERE CAST(gt.lpep_pickup_datetime AS DATE) >= DATE '2019-09-01'`
        `AND CAST(gt.lpep_pickup_datetime AS DATE) <= DATE '2019-09-30'`
        `AND poz."Zone" = 'Astoria'`
    `GROUP BY doz."Zone"`
    `ORDER BY max_tip DESC`
    `LIMIT 1`


### Question 7. Creating Resources
- Output:
`@kdayno ➜ /workspaces/data-engineering-zoomcamp/01-docker-terraform/1_terraform_gcp (main) $ terraform apply`

`Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:`
  `+ create`

`Terraform will perform the following actions:`

  `# google_bigquery_dataset.demo-dataset will be created`
  `+ resource "google_bigquery_dataset" "demo-dataset" {`
      `+ creation_time              = (known after apply)`
      `+ dataset_id                 = "demo_dataset"`
      `+ default_collation          = (known after apply)`
      `+ delete_contents_on_destroy = false`
      `+ effective_labels           = (known after apply)`
      `+ etag                       = (known after apply)`
      `+ id                         = (known after apply)`
      `+ is_case_insensitive        = (known after apply)`
      `+ last_modified_time         = (known after apply)`
      `+ location                   = "US"`
      `+ max_time_travel_hours      = (known after apply)`
      `+ project                    = "data-eng-zoomcamp-2024-412913"`
      `+ self_link                  = (known after apply)`
      `+ storage_billing_model      = (known after apply)`
      `+ terraform_labels           = (known after apply)`
    `}`

  `# google_storage_bucket.demo-bucket will be created`
  `+ resource "google_storage_bucket" "demo-bucket" {`
      `+ effective_labels            = (known after apply)`
      `+ force_destroy               = true`
      `+ id                          = (known after apply)`
      `+ location                    = "US"`
      + name                        = `"data-eng-zoomcamp-2024-412913-terra-bucket"`
      `+ project                     = (known after apply)`
      `+ public_access_prevention    = (known after apply)`
      `+ rpo                         = (known after apply)`
      `+ self_link                   = (known after apply)`
      `+ storage_class               = "STANDARD"`
      `+ terraform_labels            = (known after apply)`
      `+ uniform_bucket_level_access = (known after apply)`
      `+ url                         = (known after apply)`

      `+ lifecycle_rule {`
          `+ action {`
              `+ type = "AbortIncompleteMultipartUpload"`
            `}`
          `+ condition {`
              `+ age                   = 1`
              `+ matches_prefix        = []`
              `+ matches_storage_class = []`
              `+ matches_suffix        = []`
              `+ with_state            = (known after apply)`
            `}`
        `}`
    `}`

`Plan: 2 to add, 0 to change, 0 to destroy.`

`Do you want to perform these actions?`
  `Terraform will perform the actions described above.`
  `Only 'yes' will be accepted to approve.`

  `Enter a value: no`

`Apply cancelled.`