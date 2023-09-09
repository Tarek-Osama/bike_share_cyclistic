/*
Removing lat and long columns because they will not be used in the analysis.
*/

--before running the query, Note: change query sittings for destination to "Set a destination table for query results".
--to create a permanent table named "all_yr_but_lat_long".


SELECT
  ride_id,
  rideable_type,
  started_at,
  ended_at,
  start_station_name,
  start_station_id,
  end_station_name,
  end_station_id,
  member_casual,
  day_of_week
FROM
  `cyc-trips-2022.data_2022.all_yr_trips`
