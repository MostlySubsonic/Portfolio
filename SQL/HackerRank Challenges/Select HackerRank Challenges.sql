/*
Challenge: Occupations
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.
Note: Print NULL when there are no more names corresponding to an occupation.
*/

SELECT  [Doctor],
        [Professor],
        [Singer],
        [Actor] 
FROM    (SELECT Name, 
                Occupation, 
                ROW_NUMBER() OVER(PARTITION BY Occupation ORDER BY Name) AS var_row_number 
         FROM   OCCUPATIONS) AS SOURCE 
PIVOT 
(
MAX(NAME) 
FOR Occupation IN ([Doctor],[Professor],[Singer], [Actor])
) AS PivotTable;

/*
Challenge: Print Prime Numbers
Write a query to print all prime numbers less than or equal to 1000. Print your result on a single line, and use the ampersand (&) character as your separator (instead of a space).
*/

DECLARE @number int = 3,
        @testNum int = 2,
        @list varchar(642) = '2';

WHILE @number <= 1000 BEGIN
   WHILE(@testNum < @number) BEGIN
    IF(@number % @testNum <> 0) 
        SET @testNum += 1;
        ELSE SET @testNum = 1001
   END;
    IF(@testnum = @number)
        SET @list = CONCAT(@list,'&',@number);
        SET @testNum = 2;
        SET @number += 1;
END;

PRINT(@list);

/*
Challenge: The Report
Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.
*/

SELECT  CASE
            WHEN G.Grade < 8 THEN NULL
            ELSE s.Name
        END,
        g.Grade,
        s.Marks
FROM    STUDENTS s
INNER JOIN  GRADES g ON S.MARKS BETWEEN g.Min_Mark AND g.Max_Mark
ORDER BY    g.Grade DESC,
            s.Name,
            s.Marks;

/*
Challenge: Binary Tree
Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:
    Root: If node is root node.
    Leaf: If node is leaf node.
    Inner: If node is neither root nor leaf node.
*/

SELECT  N,
        CASE
            WHEN P IS NULL THEN 'Root'
            WHEN N IN
                (SELECT DISTINCT P
                    FROM BST
                    WHERE P IS NOT NULL) THEN 'Inner'
            ELSE 'Leaf'
        END
FROM    BST
ORDER BY N;

/*
Challenge: New Companies
Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.
*/

SELECT  comp.company_code,
        comp.founder,
        COUNT(DISTINCT emp.lead_manager_code),
        COUNT(DISTINCT emp.senior_manager_code),
        COUNT(DISTINCT emp.manager_code),
        COUNT(DISTINCT emp.employee_code)
FROM    COMPANY comp
INNER JOIN  EMPLOYEE emp on emp.company_code = comp.company_code
GROUP BY    comp.company_code,
            comp.founder
ORDER BY    comp.company_code ASC

/*
Challenge: Weather Observation Station 19
Consider P1(a,c) and P2(b,d) to be two points on a 2D plane (a,b) where are the respective minimum and maximum values of Northern Latitude (LAT_N) and (c,d) are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.

Query the Euclidean Distance between points P1 and P2 and format your answer to display decimal digits.
*/

DECLARE @pointA decimal(7,4),
        @pointB decimal(7,4),
        @pointC decimal(7,4),
        @pointD decimal(7,4);

SET @pointA = (SELECT MIN(LAT_N)
               FROM    STATION);
SET @pointB = (SELECT MAX(LAT_N)
               FROM    STATION);
SET @pointC = (SELECT MIN(LONG_W)
               FROM    STATION);
SET @pointD = (SELECT MAX(LONG_W)
               FROM    STATION);

SELECT  CAST(SQRT(POWER(@pointA - @pointB, 2) + POWER(@pointC - @pointD, 2)) AS decimal(7,4));

/*
Challenge: Weather Observation Station 17
Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7780. Round your answer to 4 decimal places.
*/

SELECT  CAST(LONG_W AS decimal(7,4))
FROM    STATION
WHERE   LAT_N = (SELECT MIN(LAT_N)
                 FROM   STATION
                 WHERE  LAT_N > 38.7780);

