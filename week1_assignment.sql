# Q1: How many airplanes have listed speeds? What is the minimum listed speed and the maximum listed speed?

SELECT COUNT(*) AS Listed_Speed FROM planes WHERE speed IS NOT NULL;
SELECT MAX(speed) FROM planes;
SELECT MIN(speed) FROM planes;

# Q2: What is the total distance flown by all of the planes in January 2013? What is the total distance flown by all of the planes in January 2013 where the tailnum is missing?
SELECT SUM(distance) FROM flights WHERE YEAR= 2013 AND MONTH = 1;
SELECT SUM(distance) FROM flights WHERE YEAR= 2013 AND MONTH = 1 AND tailnum IS NULL; 

# Q3: What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer? Write this statement first using an INNER JOIN, then using a LEFT OUTER JOIN. How do your results compare?
SELECT a.manufacturer AS 'Manufacturer', SUM(b.distance) AS 'Sum of Distance' FROM flights AS b 
INNER JOIN planes AS a 
ON b.tailnum=a.tailnum
WHERE b.month = 7 and day = 5
GROUP BY a.manufacturer 
ORDER BY a.manufacturer;

SELECT a.manufacturer AS 'Manufacturer', SUM(b.distance) AS 'Sum of Distance' FROM flights AS b 
LEFT OUTER JOIN planes AS a 
ON b.tailnum=a.tailnum
WHERE b.month = 7 and day = 5
GROUP BY a.manufacturer 
ORDER BY a.manufacturer;

# Q4: Group by Airport for the number of Jet Blue flights.
SELECT COUNT(a.flight) AS 'Total Number of Flights', b.faa AS 'Airport', b.name AS 'Airtport Name' FROM flights AS a 
INNER JOIN airlines AS c 
ON a.carrier=c.carrier 
INNER JOIN airports AS b ON a.origin= b.faa
WHERE c.carrier="B6" GROUP BY b.faa;


#Part 2 All data without JFK, EWR and LGA
DROP VIEW IF EXISTS data;

CREATE VIEW `data` AS SELECT
a.year AS 'Year', 
a.month AS 'Month', 
a.day AS 'Day', 
a.dep_time AS 'dep_time', 
a.dep_delay AS 'dep_delay', 
a.arr_time AS 'arr_time', 
a.arr_delay AS 'arr_delay', 
a.carrier AS 'carrier', 
a.tailnum AS 'tailnum', 
a.origin AS 'origin', 
a.dest AS 'dest', 
a.air_time AS 'air_time', 
a.distance AS 'distance', 
a.hour AS 'hour', 
a.minute AS 'minute', 
c.name AS 'Airline Names', 
b.lat AS 'lat', 
b.lon AS 'lon', 
b.alt AS 'alt', 
b.tz AS 'time zone' 
FROM flights AS a
INNER JOIN airlines AS c
ON a.carrier=c.carrier 
INNER JOIN airports AS b ON a.origin= b.faa;

SELECT * FROM data
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Flights/Data.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\n';