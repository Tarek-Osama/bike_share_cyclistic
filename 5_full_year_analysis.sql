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

--Number of trips for each user type and thier percentage out of total trips.
  
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


