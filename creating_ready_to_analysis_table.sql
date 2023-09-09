/*





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
  day_of_week,
  (ended_at - started_at) AS ride_length
FROM
  `cyc-trips-2022.data_2022.all_yr_but_lat_long`
