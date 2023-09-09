/*Bike-sharing company "Cyclistic" Case Study: 
 Updating day_of_week and ride_month columns and Creating a final table for analysis. 
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



 --Updating 'ride_month' to months names.

UPDATE
  `cyc-trips-2022.data_2022.now_ready`
SET
  ride_month =
  CASE
    WHEN ride_month = '1' THEN 'January'
    WHEN ride_month = '2' THEN 'February'
    WHEN ride_month = '3' THEN 'March'
    WHEN ride_month = '4' THEN 'April'
    WHEN ride_month = '5' THEN 'May'
    WHEN ride_month = '6' THEN 'June'
    WHEN ride_month = '7' THEN 'July'
    WHEN ride_month = '8' THEN 'August'
    WHEN ride_month = '9' THEN 'September'
    WHEN ride_month = '10' THEN 'October'
    WHEN ride_month = '11' THEN 'November'
    WHEN ride_month = '12' THEN 'December'
END
WHERE
  ride_month IN ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12')

