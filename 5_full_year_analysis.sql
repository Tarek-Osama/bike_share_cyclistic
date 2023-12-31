/*Bike-sharing company "Cyclistic" Case Study: 
  Analysis of full-year data. 
*/

--(1)--Total Trips count in each month.

SELECT
  ride_month,
  COUNT(DISTINCT ride_id) AS trips,
FROM
  `cyc-trips-2022.data_2022.now_ready`
GROUP BY
  1
ORDER BY
  2 DESC

--Trips count in each month for both user types.
  
  SELECT
  member_casual as user_type,
  ride_month,
  COUNT(DISTINCT ride_id) AS trips,
FROM
  `cyc-trips-2022.data_2022.now_ready`
GROUP BY
  1,2
ORDER BY
  1 

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

--(2)-- Number of trips and some descriptive statistics on ride length. 

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

--(3)--Trips count for both types of users by each day

SELECT
  day_of_week,
  COUNTIF(member_casual = 'casual') AS casual_trips,
  COUNTIF(member_casual = 'member') AS member_trips
FROM
  cyc-trips-2022.data_2022.now_ready
GROUP BY
  1


--(4)--The average ride time and trips count by each day for member vs. casual users

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

--(5)--Investigating the members' trips on Saturdays that passed the 25-hour cap?

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


--(6, 7, and 8)--When did members/casuals usually make a trip? (6_agg_peak-time_data file)

        -- Aggregation table is created for Tableau visualizations.
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
ORDER BY        -- ORDER BY 3 DESC, to get peak hours for members.
  2  DESC   

  
        -- Who makes more trips in the mornings/evenings?
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

       
--(9)--How did the average trip duration change throughout the day for both users?

SELECT
  CAST(ride_hour AS numeric) AS hour,
  AVG(ride_length) AS casual_avg,     -- AS member_avg
  count(ride_id) AS casual_trips      -- AS member_trips
FROM
  `cyc-trips-2022.data_2022.now_ready`
WHERE
  member_casual = 'casual' --member_casual = 'member', to get member averages.
GROUP BY
  1
ORDER BY
  1

  -- Aggregating average ride length and total trips per hour for both user type
  
  SELECT
  member_casual as user_type,
  CAST(ride_hour AS numeric) AS hour,
  AVG(ride_length) AS avg_ride_length,
  count(ride_id) AS trips     
     
  FROM
  `cyc-trips-2022.data_2022.now_ready`

  GROUP BY
    1,2
  ORDER BY
    1,2

                  
--(10)--Aggregating rideable type data.
SELECT

  member_casual as user_type,
  rideable_type,
  day_of_week,
  count(*) as total_trips,
  avg(ride_length) as avg_ride_length,
  max(ride_length) as max_ride_length,
  min(ride_length) as min_ride_length
FROM
  `cyc-trips-2022.data_2022.now_ready` 

GROUP BY
  1, 2, 3
ORDER BY
  1  


          --What is the most common rideable type for both users? 
  
SELECT
  rideable_type,
  COUNTIF(member_casual = 'casual') AS casual_trips,
  COUNTIF(member_casual = 'member') AS member_trips,
FROM
  `cyc-trips-2022.data_2022.now_ready`
GROUP BY
  1

         --What is the average ride length for each rideable type by each user?

SELECT
  member_casual as user_type,
  rideable_type,
  count(*) as total_trips,
  avg(ride_length) as avg_ride_length,
  max(ride_length) as max_ride_length,
  min(ride_length) as min_ride_length
FROM
  `cyc-trips-2022.data_2022.now_ready` 
GROUP BY
  1, 2
ORDER BY
  1  

--(11)A closer look into docked bike data.

SELECT
  day_of_week,  --ride_month, to get docked trip counts and average by month.
                --ride_hour,  to get docked trip counts and average by hour.
  count(*) as total_trips,
  avg(ride_length) as avg_ride_length,
  max(ride_length) as max_ride_length,
  min(ride_length) as min_ride_length
FROM
  `cyc-trips-2022.data_2022.now_ready` 
WHERE rideable_type = "docked_bike"  
GROUP BY
  1

--(12)--What are the most common start and end stations for both users? and are there any similarities?

     -- See top 10 start stations for casuals vs. members
SELECT
  DISTINCT start_station_name,
  COUNT(*) AS total,
  COUNTIF(member_casual ='casual') AS casual_trips,
  COUNTIF(member_casual = 'member') AS member_trips
FROM
  `cyc-trips-2022.data_2022.now_ready`
WHERE
  start_station_name IS NOT NULL
GROUP BY
  1
ORDER BY
  3 DESC  --2 DESC, top 10 in total.
          --4 DESC, top 10 for members.
LIMIT 10

      -- See top 10 end stations for casuals vs. members

SELECT
  DISTINCT end_station_name,
  COUNT(*) AS total,
  COUNTIF(member_casual ='casual') AS casual_trips,
  COUNTIF(member_casual = 'member') AS member_trips
FROM
  `cyc-trips-2022.data_2022.now_ready`
WHERE
  end_station_name IS NOT NULL
GROUP BY
  1
ORDER BY
 3 DESC   --2 DESC, top 10 in total.
          --4 DESC, top 10 for members.
LIMIT 10


  --(13)--What is the probability of starting a trip and ending it at the same station for both user types?

SELECT
  total_trips,
  total_casual_trips,
  CasualSameStartEndTrips,
  ROUND(((CasualSameStartEndTrips / total_casual_trips)*100), 2) AS percentage_of_total_casual,
  total_member_trips,
  MemberSameStartEndTrips,
  ROUND(((MemberSameStartEndTrips / total_member_trips)*100), 2) AS percentage_of_total_member
FROM (
  SELECT
    COUNT(ride_id) AS total_trips,
    COUNTIF(member_casual = 'casual') AS total_casual_trips,
    COUNTIF(member_casual = 'casual'
      AND start_station_name = end_station_name) AS CasualSameStartEndTrips,
    COUNTIF(member_casual = 'member') AS total_member_trips,
    COUNTIF(member_casual = 'member'
      AND start_station_name = end_station_name) AS MemberSameStartEndTrips,
  FROM
    `cyc-trips-2022.data_2022.now_ready` )


--Note: hay!! .. For each station of the top 10 list, What is the probability of starting a trip and ending it at the same station for both user types??
