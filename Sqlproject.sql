use employer;

#exploring tables
  select * from goldstardatainsheets;
  
  select * from position;
  select * from location;
  
  
#Altering the column name
 alter table goldstardatainsheets rename column ssn to id;
 
#Altering table name
alter table goldstardatainsheets rename to emp;


#changing data type of column.first i needed to drop "$" and other string values in salary column and then change it to float
UPDATE emp
SET salary = REPLACE(salary, '$', '');


#dropping ".00" string value
UPDATE emp
SET salary = REPLACE(salary, '.00', '');

#altering salary column data type to Float
ALTER TABLE emp MODIFY COLUMN salary FLOAT;


#selecting special columns and ordering one of them in a desc order
select id, lastname, firstname, hiredate from emp order by 2 desc;


#limiting rows 
select * from emp order by id limit 5;


#using 'where' clause
 select salary from emp where salary> 50000;

#max salary
select max(salary) from emp;
 
 #min salary
select min(salary) from emp;

#avarege salary
select avg(salary) from emp;
  
#using distinct
select distinct lastname,firstname from emp;

#Advanced queries- I perform an Inner join on three tables: emp, location, and position. 
#The result includes the employer names, their job titles, cities, states, and addresses

SELECT e.lastname,e.firstname AS employer_name,e.salary, p.positiontitle AS position_title, l.locationcity as city, l.state, l.address
FROM emp e
JOIN position p ON e.positionID = p.positionID
JOIN location l ON e.locationID = l.locationID;


#This query will count the number of unique locations associated with each employee
# and filter out employees who have fewer than two distinct locations.
SELECT e.lastname,firstname AS employer_name, COUNT(DISTINCT l.locationID) AS num_locations
FROM emp e
JOIN location l ON e.locationID = l.locationID
GROUP BY e.firstname,e.lastname
hAVING COUNT(DISTINCT l.locationID) > 1;


#selectin min and max salary for each position
(select min(salary),max(salary),positionID from emp group by positionID);


#selecting min and max salary for each position and showing positiontitle as well.I used Inner join to show poitiontitle column in the output
SELECT e.positionID, p.positiontitle, MIN(e.salary) AS min_salary, MAX(e.salary) AS max_salary
FROM emp e
JOIN position p ON e.positionID = p.positionID
GROUP BY e.positionID;

#using Subquery. This query show the employers who earn more than avg salary
select firstname,lastname,salary from emp where salary>(select avg(salary)from emp);

#Using Subquery.This query show the employers who earn less than avg salary
select firstname,lastname,salary from emp where salary<=(select avg(salary)from emp);

#finding employees whose position title is "Manager" with Inner Join
select e.lastname,e.firstname, e.positionID,p.positiontitle from emp e join position p on e.positionID=p.positionID where 
p.positiontitle="Manager";


#Finding the number of employees per location with Inner Join and Subquery
select l.locationcity, l.state, count_of_emp.num from location l
join 
(select count(id) as num, e.locationid as locationId from emp e group by e.locationid) count_of_emp
on count_of_emp.locationId = l.locationID;

#second way to find the number of employees per location with Nested Subquery
select count(*), (select l.locationcity from location l where l.locationId = e.locationId) location_name
from emp e
group by e.locationId
;

#Counting the number of positions per State with Inner Join and Subquery
select l.state,num.num_of_position from location l join
(select count(positionid) num_of_position, locationid from emp group by locationid) as num
on l.locationid=num.locationid;

# second way to count the number of positions per State with only INNER JOIN
SELECT l.state, COUNT(*) AS num_positions
FROM emp e
JOIN location l ON e.locationid = l.locationid
GROUP BY l.state;







