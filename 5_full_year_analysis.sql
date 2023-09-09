/*Bike-sharing company "Cyclistic" Case Study: 
  Analysis on full-year data. 
*/

--Trips count in each month.

SELECT
  ride_month,
  COUNT(DISTINCT ride_id) AS trips,
FROM
  `cyc-trips-2022.data_2022.now_ready`
GROUP BY
  1
ORDER BY
  2 DESC

--Number of trips for each user type and their percentage out of total trips.
  
SELECT
casual_trips,
round((casual_trips/total_trips), 4)*100 as casual_percsntage,
member_trips,
round((member_trips/total_trips), 4)*100 as member_percentage
from
(
SELECT  
count(ride_id) as total_trips,
countif(member_casual = 'casual') as casual_trips,
countif(member_casual = 'member') as member_trips 

FROM `cyc-trips-2022.data_2022.now_ready` 

)

-- Number of trips and some descriptive statistics on ride length. 

SELECT  
  member_casual as user_type,
  count(ride_id) as total_trips,
  avg(ride_length) as avg_ride_length,
  max(ride_length) as max_ride_length,
  min(ride_length) as min_ride_length,
 
FROM `cyc-trips-2022.data_2022.now_ready` 
group by 1

-- Top days in trip count for both types of users.
  
SELECT
  day_of_week,
  COUNT(*) AS trips,
FROM
  `cyc-trips-2022.data_2022.now_ready`
WHERE
  member_casual = 'casual' 
--WHERE member_casual = 'member'
GROUP BY
  1
ORDER BY
  2 DESC

--Trip counts for both types of users by each day

SELECT
  day_of_week,
  COUNTIF(member_casual = 'casual') AS casual_trips,
  COUNTIF(member_casual = 'member') AS member_trips
FROM
  cyc-trips-2022.data_2022.now_ready
GROUP BY
  1


--The average ride time and trip counts by each day for member vs. casual users

SELECT
  member_casual as user_type,
  day_of_week,
  count(*) as total_trips,
  avg(ride_length) as avg_ride_length,
  max(ride_length) as max_ride_length,
  min(ride_length) as min_ride_length

FROM
  cyc-trips-2022.data_2022.now_ready
GROUP BY
  1, 2
ORDER BY 
  1

--Investigating the members' trips on Saturdays that passed the 25-hour cap?

SELECT
  ride_id,
  member_casual as user_type,
  day_of_week,
  ride_length,
  extract(hour from ride_length) as ride_length_in_hour,
  rideable_type,
  start_station_name,
  end_station_name,
  ride_hour,
  ride_month
  
FROM
  cyc-trips-2022.data_2022.now_ready
WHERE 
  day_of_week = 'Saturday'
  and
  member_casual = 'member'
  and 
  extract(hour from ride_length) > 25


--When did members/casuals usually make a trip?

        -- This table is created for Tableau visualizations.
SELECT
  ride_month,
  day_of_week,
  ride_hour,
  COUNTIF(member_casual = 'casual') AS casual_trips,
  COUNTIF(member_casual = 'member') AS member_trips

FROM `cyc-trips-2022.data_2022.now_ready`

GROUP BY
  1, 2, 3
ORDER BY
  3  

        -- Peak hours for casuals.
SELECT
  ride_hour,
  COUNTIF(member_casual = 'casual') AS casual_trips,
  COUNTIF(member_casual = 'member') AS member_trips

FROM `cyc-trips-2022.data_2022.now_ready`

GROUP BY
  1
ORDER BY
  2  DESC    -- ORDER BY 3 DESC, to get peak hours for members.

        -- Who makes more trips in the mornings?
SELECT
  cast(ride_hour as numeric) as hour,
  COUNTIF(member_casual = 'casual') AS casual_trips,
  COUNTIF(member_casual = 'member') AS member_trips

FROM `cyc-trips-2022.data_2022.now_ready`

where 
   cast(ride_hour as numeric) between 4 and 10        -- cast(ride_hour as numeric) >= 19,  Who makes more trips in the evenings? 
GROUP BY
  1
ORDER BY 
  1 

       
--How did average ride_length change throughout the day for both users?

SELECT
  CAST(ride_hour AS numeric) AS hour,
  AVG(ride_length) AS casual_avg,     -- AS member_avg
  count(ride_id) AS casual_trips      -- AS member_avg
FROM
  `cyc-trips-2022.data_2022.now_ready`
WHERE
  member_casual = 'casual' --member_casual = 'member', to get member averages.
GROUP BY
  1
ORDER BY
  1




























