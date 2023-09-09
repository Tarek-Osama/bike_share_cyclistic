/*Bike-sharing company "Cyclistic" Case Study: 
 Changing data type for some columns and Creating a final table for analysis. 
*/

--before running the query, Note: change query sittings for destination to "Set a destination table for query results".
--to create a permanent table named "now_ready".

SELECT
  ride_id,
  member_casual,
  rideable_type,
  started_at,
  ended_at,
  CAST(EXTRACT(month
    FROM
      started_at) AS string) AS ride_month,
  CAST(day_of_week AS STRING) AS day_of_week,
  CAST(EXTRACT(hour
    FROM
      started_at) AS string) AS ride_hour,
  ride_length,
  start_station_name,
  start_station_id,
  end_station_name,
  end_station_id

FROM `cyc-trips-2022.data_2022.ready_to_analysis`


-- Updating day_of_week to days names.

UPDATE
  `cyc-trips-2022.data_2022.now_ready`
SET
  day_of_week =
  CASE
    WHEN day_of_week = '1' THEN 'Sunday'
    WHEN day_of_week = '2' THEN 'Monday'
    WHEN day_of_week = '3' THEN 'Tuesday'
    WHEN day_of_week = '4' THEN 'Wednesday'
    WHEN day_of_week = '5' THEN 'Thursday'
    WHEN day_of_week = '6' THEN 'Friday'
    WHEN day_of_week = '7' THEN 'Saturday'
END
WHERE
  day_of_week IN ('1', '2', '3', '4', '5', '6', '7')
