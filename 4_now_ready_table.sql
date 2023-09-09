/*Bike-sharing company "Cyclistic" Case Study: 
 Changing data type for some columns and Creating final table to analysis. 
*/



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




