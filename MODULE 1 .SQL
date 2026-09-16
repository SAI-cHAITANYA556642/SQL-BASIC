MODULE 1 — SQL BASICS

We'll start from the absolute beginning.

1. SQL
Definition

SQL (Structured Query Language) is a language used to store, retrieve, filter, analyze, and manipulate data in relational databases.

Example
SELECT *
FROM guidein_dataset;
Output
user_id	visit_date	visited	registered	logged_in	subscribed
1	2026-01-01	1	1	1	1
2	2026-01-01	1	1	0	0
3	2026-01-02	1	0	0	0
Interview answer

SQL is a language used to communicate with relational databases. We use SQL to retrieve, filter, manipulate, and analyze data.

2. MySQL
Definition

MySQL is a relational database management system that uses SQL to store and manage data.

Example
USE guidein_analysis;
Output
Database changed
Interview answer

MySQL is a relational database management system. SQL is the language I use to work with data inside MySQL.

3. DATABASE
Definition

A database is an organized collection of data.

Example
CREATE DATABASE guidein_analysis;

If it already exists:

CREATE DATABASE IF NOT EXISTS guidein_analysis;
Output
Query OK
4. TABLE
Definition

A table stores data in rows and columns.

Your GuideIn project uses:

guidein_dataset

Example:

user_id	visit_date	visited	registered
1	2026-01-01	1	1
2	2026-01-01	1	0
3	2026-01-02	1	1
5. ROW
Definition

A row represents one record in a table.

Example:

1 | 2026-01-01 | 1 | 1 | 1 | 1

This represents one user's record.

6. COLUMN
Definition

A column represents a particular attribute or field.

Example:

user_id
visit_date
visited
registered
logged_in
subscribed
7. DATA TYPES
Definition

A data type defines what kind of value a column can store.

Common MySQL types:

Data Type	Purpose	Example
INT	Whole number	101
DECIMAL	Decimal number	99.50
VARCHAR	Text	'Google'
TEXT	Large text	'Description'
DATE	Date	2026-01-01
DATETIME	Date + time	2026-01-01 10:30:00
BOOLEAN	True/false	1 / 0

GuideIn example:

user_id INT
visit_date DATE
service TEXT
source TEXT
device TEXT
8. PRIMARY KEY
Definition

A primary key uniquely identifies each row in a table.

GuideIn:

user_id INT PRIMARY KEY

Example:

user_id	service
101	Basic
102	Premium
103	Basic

Here user_id identifies each user.

Interview answer

A primary key uniquely identifies each record in a table. It cannot contain duplicate values.

9. CREATE DATABASE
Example
CREATE DATABASE IF NOT EXISTS guidein_analysis;
Output
Query OK
10. USE DATABASE
Definition

USE selects the database on which you want to work.

Query
USE guidein_analysis;
Output
Database changed
11. CREATE TABLE
Query
CREATE TABLE guidein_dataset (
    user_id INT PRIMARY KEY,
    visit_date DATE,
    visited INT,
    registered INT,
    logged_in INT,
    subscribed INT,
    service TEXT,
    source TEXT,
    device TEXT
);
Output
Query OK
12. DROP TABLE
Definition

DROP TABLE permanently removes a table and its data.

Query
DROP TABLE guidein_dataset;
Output
Query OK

Safer version:

DROP TABLE IF EXISTS guidein_dataset;
13. INSERT INTO
Definition

INSERT INTO adds new records to a table.

Query
INSERT INTO guidein_dataset
(user_id, visit_date, visited, registered, logged_in, subscribed, service, source, device)
VALUES
(501, '2026-09-16', 1, 1, 1, 1, 'Premium', 'Google', 'Mobile');
Output
user_id	visit_date	visited	registered	logged_in	subscribed	service	source	device
501	2026-09-16	1	1	1	1	Premium	Google	Mobile
14. SELECT

This is one of the most important SQL commands.

Definition

SELECT retrieves data from a table.

Query
SELECT *
FROM guidein_dataset;
Output
user_id	visit_date	visited	registered	logged_in	subscribed
1	2026-01-01	1	1	1	1
2	2026-01-01	1	1	0	0
3	2026-01-02	1	0	0	0

* means all columns.

Selecting specific columns
SELECT user_id, visit_date, service
FROM guidein_dataset;
Output
user_id	visit_date	service
1	2026-01-01	Premium
2	2026-01-01	Basic
3	2026-01-02	Premium
Interview answer

SELECT is used to retrieve data from one or more tables.

15. SELECT DISTINCT
Definition

DISTINCT removes duplicate values from the result.

Query
SELECT DISTINCT service
FROM guidein_dataset;
Output
service
Basic
Premium
Enterprise

Without DISTINCT, the same service could appear many times.

16. LIMIT
Definition

LIMIT restricts the number of rows returned.

Query
SELECT *
FROM guidein_dataset
LIMIT 5;
Output
user_id	visit_date	visited	registered
1	2026-01-01	1	1
2	2026-01-01	1	1
3	2026-01-02	1	0
4	2026-01-02	1	1
5	2026-01-03	1	1
FIRST IMPORTANT SQL PATTERN

You should remember this structure:

SELECT column_name
FROM table_name
WHERE condition
GROUP BY column_name
HAVING condition
ORDER BY column_name
LIMIT number;

Not every query needs every clause.

For example:

SELECT service, COUNT(*) AS total_users
FROM guidein_dataset
WHERE visited = 1
GROUP BY service
HAVING COUNT(*) > 10
ORDER BY total_users DESC
LIMIT 5;

This single query uses several important SQL concepts:

SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT

YOUR FIRST SQL INTERVIEW QUESTIONS
Q1. What is SQL?

Answer:

SQL stands for Structured Query Language. It is used to communicate with relational databases and perform operations such as retrieving, filtering, inserting, updating, and analyzing data.

Q2. What is MySQL?

Answer:

MySQL is a relational database management system that uses SQL to store and manage structured data.

Q3. What is a table?

Answer:

A table is a structured collection of data organized into rows and columns.

Q4. What is a primary key?

Answer:

A primary key uniquely identifies each record in a table and does not allow duplicate values.

Q5. What does SELECT do?

Answer:

SELECT is used to retrieve data from a database table.

Q6. What does DISTINCT do?

Answer:

DISTINCT removes duplicate values from the query result.

Q7. What does LIMIT do?

Answer:

LIMIT restricts the number of rows returned by a query.
