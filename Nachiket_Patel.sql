Question#1:

# Write a query to return columns id and extra from table SLEEP.
1. SELECT id,extra FROM SLEEP;
# Rewrite the previous query so that extra will appear as the first column in your query result
2. SELECT extra,id FROM SLEEP;
# Write a query to return all the category values, without repetitions.
3. SELECT DISTINCT category FROM SLEEP;
# Write a query to return every id whose extra > 0.
4. SELECT id FROM SLEEP WHERE extra > 0;
# Write a query to return the total of extra in each category (call it extraSum) and the number of records in each category (call it categoryNum).
5. SELECT SUM(extra) AS extrasum, COUNT(category) AS categoryNum FROM SLEEP GROUP BY category;
# Write a query to return the average extra of each category (call it mean_extra).
6. SELECT category, AVG(extra) AS mean_extra FROM SLEEP GROUP BY category;


Question#2:

# Select the first two rows in table Department
1. SELECT * FROM Department LIMIT 2;
# Write a query to return the employeename, hiredate, basewage from table Employee.
2. SELECT employeename, hiredate, basewage FROM Employee;
# Write a query to return the total wage of employees.
# total wage = basewage ∗ wagelevel
3. SELECT employeename,basewage*wagelevel AS total_wage FROM Employee;
# Write a query to return names of employees whose basewage ranges from 2000 to 3000, sort the result by basewage in descending order. (Look up online how to use ORDER BY to sort descending.)
4. SELECT employeename,basewage FROM Employee WHERE basewage >= 2000 AND basewage <= 3000 ORDER BY basewage DESC;
# Write a query to return the employeename, hiredate, basewage whose name ends with 8 ​and who was hired after June 10, 2010. (Hint: read pattern matching in Mysql)
5. SELECT employeename, hiredate, basewage FROM Employee WHERE employeename LIKE '%8' AND hiredate > '2010-06-10';
# Write a query to return the employeename and corresponding departmentid whose total wage is larger than 7000.
6. SELECT employeename,departmentid,BaseWage*WageLevel AS totalwage FROM Employee HAVING totalwage > 7000;
# Write a query to return the departmentid of departments that have at least 2 employees with basewage >= 3000.
7. SELECT departmentid FROM Employee WHERE basewage >= 3000 GROUP BY DepartmentID HAVING COUNT(departmentid) >= 2;
# Write a query to return the average total wage in each department. Sort the results by average wage in ascending order.
8. SELECT DepartmentID, AVG(basewage*wagelevel) AS totalwage FROM Employee GROUP BY DepartmentID ORDER BY totalwage ASC;
# Write a query to return the average total wage of males and females in each department. Sort the results by DepartmentID in descending order.
9. SELECT EmployeeSex,DepartmentID, AVG(basewage*wagelevel) AS totalwage FROM Employee GROUP BY EmployeeSex,DepartmentID ORDER BY DepartmentID DESC;
# Write a query to return the name of each employee, along with his/her deparmentname and the principal in the department. (Hint: use JOIN.)
10.SELECT EmployeeName,DepartmentName,Principal FROM Employee JOIN Department ON Employee.DepartmentID = Department.DepartmentID;



Question#3:


# Download this data set; the information about attributes is here (item 7). Upload it 
# to the server using scp. Create a table named adult which has the same structure.
# Two ways to get the data on server:
# a. Download the data directly on our server using curl or wget;
# b. Download on your local machine and copy it to server using scp
1. CREATE TABLE adult (age int, workclass char(255),  fnlwgt int,  education char(255), education_num int,marital_status char(255), occupation char(255), relationship char(255), race char(255), sex char(255), capital_gain int ,capital_loss int, hours_per_week int, native_country char(255), class char(255));
   scp ./adult.data bc10_nachike@216.230.228.88:~/
# Load the data set adult.data into table adult (Note: In the original data, separators
#are “, ”[a comma followed with a space], remember to set the value of FIELDS
#TERMINATED to ”, ” instead of “,”).
2. LOAD DATA LOCAL INFILE 'adult.data' INTO TABLE adult FIELDS TERMINATED BY ', ' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';
# Are there any missing values in the table? How many rows have missing values?
# a. For numerical fields, use the ‘is null’ condition.
# b. For string fields, missing values are represented as “?”.
3.SELECT COUNT(*) FROM adult WHERE age IS NULL || fnlwgt IS NULL || education_num IS NULL || capital_gain IS NULL || capital_loss IS NULL || hours_per_week IS NULL || workclass = '?'|| education = '?' || marital_status ='?' || occupation = '?' || relationship ='?'  || race ='?'  || sex = '?' || native_country = '?' || class = '?';
# Remove the rows having missing values.
4. DELETE FROM adult WHERE age IS NULL || fnlwgt IS NULL || education_num IS NULL || capital_gain IS NULL || capital_loss IS NULL || hours_per_week IS NULL || workclass = '?'|| education = '?' || marital_status ='?' || occupation = '?' || relationship ='?'  || race ='?'  || sex = '?' || native_country = '?' || class = '?';
# What's the ratio of number of '<=50K' / number of '>50K' in column class.
5. CREATE TEMPORARY TABLE more50k AS SELECT COUNT(class) AS A FROM adult WHERE class = '>50K';
   CREATE TEMPORARY TABLE less50k AS SELECT COUNT(class) AS B FROM adult WHERE class = '<=50K';
   SELECT B/A AS Ratio FROM more50k,less50k;
# Compute the average age in each class
6. SELECT AVG(age) AS meanAge,class FROM adult GROUP BY class;
# How many rows in class ‘>50K' where the age is less than 36.78?
7. SELECT COUNT(class) FROM adult WHERE age < 36.78 AND class = '>50K';
# What's the average hours-per-week in each class?
8. SELECT class, AVG(hours_per_week) AS Avg_Hours_Per_Week FROM adult GROUP BY class;
# What's the ratio of number of '<=50K' / number of '>50K' in Female and Male
# (column sex)? (Hint: Create two “temporary” tables.)
9. CREATE TEMPORARY TABLE less50ks AS SELECT sex, COUNT(class) AS B FROM adult WHERE class = '<=50K' GROUP BY sex;
   CREATE TEMPORARY TABLE more50ks AS SELECT sex, COUNT(class) AS A FROM adult WHERE class = '>50K' GROUP BY sex;  
   SELECT less50ks.sex AS 'Sex<=50K',more50ks.sex AS 'Sex>50K', B/A  AS Ratio FROM more50ks,less50ks;





















