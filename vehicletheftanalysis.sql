-- Retrieve All Stolen Vehicles:
SELECT *
FROM stolen_vehicles;


-- Count Stolen Vehicles by Vehicle Type (Top 5):
SELECT vehicle_type, COUNT(*) AS theft_count
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY theft_count DESC
LIMIT 5;


-- Find the Most Stolen Vehicle Make:
SELECT m.make_name, COUNT(*) AS theft_count
FROM make_details m
JOIN stolen_vehicles s ON m.make_id = s.make_id
GROUP BY m.make_name
ORDER BY theft_count DESC
LIMIT 1;


-- Retrieve the 5 most recently stolen vehicles
SELECT *
FROM stolen_vehicles
ORDER BY date_stolen DESC
LIMIT 5;


-- Find the Top 5 Regions with the Highest Number of Vehicle Thefts:
SELECT l.region, COUNT(*) AS theft_count
FROM stolen_vehicles sv
JOIN locations l ON sv.location_id = l.location_id
GROUP BY l.region
ORDER BY theft_count DESC
LIMIT 5;



-- Find the Top 5 Regions with the Lowest Number of Vehicle Thefts:
SELECT l.region, COUNT(sv.vehicle_id) AS theft_count
FROM locations l
LEFT JOIN stolen_vehicles sv ON l.location_id = sv.location_id
GROUP BY l.region, l.density
ORDER BY theft_count ASC
LIMIT 5;


-- Identify Common Colors of Stolen Vehicles:
SELECT sv.color, COUNT(*) AS color_count
FROM stolen_vehicles sv
GROUP BY sv.color
ORDER BY color_count DESC;


-- Identify Common Colors of Stolen Vehicles by Make:
SELECT md.make_name, sv.color, COUNT(*) AS color_count
FROM stolen_vehicles sv
JOIN make_details md ON sv.make_id = md.make_id
GROUP BY md.make_name, sv.color
ORDER BY color_count DESC;



-- Find Vehicle Makes with More Than 200 Thefts:
SELECT make_name
FROM make_details
WHERE make_id IN (
    SELECT make_id
    FROM stolen_vehicles
    GROUP BY make_id
    HAVING COUNT(vehicle_id) > 200
);


-- Find Vehicle Makes with Models Stolen in Multiple Years:
SELECT make_name
FROM make_details
WHERE make_id IN (
    SELECT make_id
    FROM stolen_vehicles
    GROUP BY make_id
    HAVING COUNT(DISTINCT model_year) > 1
);


-- Find the Day of the Week with the Most Vehicle Thefts:
SELECT DAYNAME(date_stolen) AS day_of_week, COUNT(*) AS theft_count
FROM stolen_vehicles
GROUP BY day_of_week
ORDER BY theft_count DESC;


-- What is the average age of the vehicles that are stolen
SELECT AVG(YEAR(NOW()) - model_year) AS avg_vehicle_age
FROM stolen_vehicles;


-- Identify the Most Common Model Year for Stolen Vehicles:
SELECT model_year, COUNT(*) AS theft_count
FROM stolen_vehicles
GROUP BY model_year
ORDER BY theft_count DESC
LIMIT 1;

-- Find the Vehicle Makes with the Highest Diversity of Colors
SELECT md.make_name, COUNT(DISTINCT sv.color) AS color_count
FROM make_details md
LEFT JOIN stolen_vehicles sv ON md.make_id = sv.make_id
GROUP BY md.make_name
ORDER BY color_count DESC
LIMIT 1;

