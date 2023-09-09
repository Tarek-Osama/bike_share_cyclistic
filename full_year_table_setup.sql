/*
Bike-sharing company "Cyclistic" Case Study: 
Combining all monthly datasets into one full-year table.

  The UNION ALL combines SELECT statements results. 
  SELECT statements results must have the same number of columns 
  and the same data types in each column. 
  but it does not remove any duplicate rows 
  no problem, Duplicates have been removed before loading data to query.
*/


SELECT                                 
  * 
FROM
  cyc-trips-2022.data_2022.jan
UNION ALL
SELECT
  *
FROM
  cyc-trips-2022.data_2022.feb
UNION ALL
SELECT
  *
FROM
  cyc-trips-2022.data_2022.mar
UNION ALL
SELECT
  *
FROM
  cyc-trips-2022.data_2022.apr
UNION ALL
SELECT
  *
FROM
  cyc-trips-2022.data_2022.may
UNION ALL
SELECT
  *
FROM
  cyc-trips-2022.data_2022.jun
UNION ALL
SELECT
  *
FROM
  cyc-trips-2022.data_2022.jul
UNION ALL
SELECT
  *
FROM
  cyc-trips-2022.data_2022.aug
UNION ALL
SELECT
  *
FROM
  cyc-trips-2022.data_2022.sep
UNION ALL
SELECT
  *
FROM
  cyc-trips-2022.data_2022.oct
UNION ALL
SELECT
  *
FROM
  cyc-trips-2022.data_2022.nov
UNION ALL
SELECT
  *
FROM
  cyc-trips-2022.data_2022.dec
