select * from road_accident

SELECT SUM(number_of_casualties) AS CY_Casualties
FROM road_accident
WHERE YEAR(accident_date) = '2022'

SELECT SUM(number_of_casualties) AS CY_Casualties
FROM road_accident
WHERE YEAR(accident_date) = '2022' AND road_surface_conditions = 'Dry'

SELECT COUNT(DISTINCT accident_index) AS CY_Accidents
FROM road_accident
WHERE YEAR(accident_date) = '2022'

SELECT SUM(number_of_casualties) AS CY_Fatal_Casualties
FROM road_accident
WHERE YEAR(accident_date) = '2022'

SELECT SUM(number_of_casualties) AS CY_Fatal_Casualties
FROM road_accident
WHERE accident_severity = 'Fatal'

SELECT SUM(number_of_casualties) AS CY_Fatal_Casualties
FROM road_accident
WHERE accident_severity = 'Fatal'

SELECT SUM(number_of_casualties) AS CY_Serious_Casualties
FROM road_accident
WHERE accident_severity = 'Serious' 

SELECT SUM(number_of_casualties) AS CY_Serious_Casualties
FROM road_accident
WHERE YEAR(accident_date) = '2022' AND accident_severity = 'Serious';

SELECT SUM(number_of_casualties) AS CY_Slight_Casualties
FROM road_accident
WHERE YEAR(accident_date) = '2022' AND accident_severity = 'Slight';

SELECT SUM(number_of_casualties) AS CY_Slight_Casualties
FROM road_accident
WHERE accident_severity = 'Slight';

SELECT SUM(number_of_casualties) * 1.0 / (SELECT SUM(number_of_casualties) FROM road_accident) AS Percentage_Slight
FROM road_accident WHERE accident_severity = 'Slight';

SELECT SUM(number_of_casualties) * 1.0 / (SELECT SUM(number_of_casualties) FROM road_accident) AS Percentage_Slight
FROM road_accident WHERE accident_severity = 'Serious';

SELECT SUM(number_of_casualties) * 1.0 / (SELECT SUM(number_of_casualties) FROM road_accident) AS Percentage_Slight
FROM road_accident WHERE accident_severity = 'Fatal';

SELECT 
CASE 
WHEN vehicle_type IN ('Agricultural vehicle') THEN 'Agricultural'
WHEN vehicle_type IN ('Car', 'Taxi/Private hire car') THEN 'Cars'
WHEN vehicle_type IN ('Motorcycle 125cc and under', 'Motorcycle 50cc and under', 'Motorcycle over 125cc and up to 500cc', 'Motorcycle over 500cc', 'Pedal cycle') THEN 'Bike'
WHEN vehicle_type IN ('Bus or coach (17 or more pass seats)', 'Minibus (8 - 16 passenger seats)') THEN 'Bus'
WHEN vehicle_type IN ('Goods 7.5 tonnes mgw and over', 'Goods over 3.5t. and under 7.5t.', 'Van / Goods 3.5 tonnes mgw or under') THEN 'Van'
ELSE 'Other'
END As vehicle_group,
SUM(number_of_casualties) as CY_Casualties
FROM road_accident
WHERE YEAR(accident_date) = '2022'
GROUP BY 
CASE 
WHEN vehicle_type IN ('Agricultural vehicle') THEN 'Agricultural'
WHEN vehicle_type IN ('Car', 'Taxi/Private hire car') THEN 'Cars'
WHEN vehicle_type IN ('Motorcycle 125cc and under', 'Motorcycle 50cc and under', 'Motorcycle over 125cc and up to 500cc', 'Motorcycle over 500cc', 'Pedal cycle') THEN 'Bike'
WHEN vehicle_type IN ('Bus or coach (17 or more pass seats)', 'Minibus (8 - 16 passenger seats)') THEN 'Bus'
WHEN vehicle_type IN ('Goods 7.5 tonnes mgw and over', 'Goods over 3.5t. and under 7.5t.', 'Van / Goods 3.5 tonnes mgw or under') THEN 'Van'
ELSE 'Other'
END

SELECT DATENAME(MONTH, accident_date) AS Month_Name, SUM(number_of_casualties)
FROM road_accident
WHERE YEAR(accident_date) = '2022'
GROUP BY DATENAME(MONTH, accident_date)

SELECT road_type, SUM(number_of_casualties) AS CY_Casualties FROM road_accident
WHERE YEAR(accident_date) = '2022'
GROUP BY road_type
  
SELECT urban_or_rural_area, SUM(number_of_casualties) FROM road_accident
WHERE YEAR(accident_date) = '2022'
GROUP BY urban_or_rural_area

SELECT urban_or_rural_area, SUM(number_of_casualties) * 100 /
(SELECT SUM(number_of_casualties) FROM road_accident WHERE YEAR(accident_date) = '2022')
FROM road_accident
WHERE YEAR(accident_date) = '2022'
GROUP BY urban_or_rural_area

SELECT 
CASE 
WHEN light_conditions IN ('Daylight') THEN 'Day'
WHEN light_conditions IN ('Darkness - lighting unknown', 'Darkness - lights lit', 'Darkness - lights unlit', 'Darkness - no lighting') THEN 'Night'
END AS Light_Condition,
CAST(CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) * 100 / 
(SELECT CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) FROM road_accident WHERE YEAR(accident_date) = '2022') 
AS DECIMAL(10,2)) AS CY_Casualties_PCT
FROM road_accident
WHERE YEAR(accident_date) = '2022'
GROUP BY 
CASE 
WHEN light_conditions IN ('Daylight') THEN 'Day'
WHEN light_conditions IN ('Darkness - lighting unknown', 'Darkness - lights lit', 'Darkness - lights unlit', 'Darkness - no lighting') THEN 'Night'
END

SELECT local_authority, SUM(number_of_casualties) AS Total_Casualties
FROM road_accident
GROUP BY local_authority

SELECT TOP 10 local_authority, SUM(number_of_casualties) AS Total_Casualties
FROM road_accident
GROUP BY local_authority
ORDER BY Total_Casualties DESC