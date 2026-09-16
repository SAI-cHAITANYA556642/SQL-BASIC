MODULE 4 — SQL AGGREGATE FUNCTIONS

Aggregate functions are very important for Data Analyst and Business Analyst interviews because they help calculate business metrics such as total users, registrations, subscriptions, averages, minimums, and maximums.

We will use the GuideIn project for examples.

41. COUNT()
Definition

COUNT() is used to count records or values.

Basic syntax
SELECT COUNT(column_name)
FROM table_name;
Example

Count the number of user_id values:

SELECT COUNT(user_id) AS total_users
FROM guidein_dataset;
Output
total_users
500

If your GuideIn dataset contains 500 records, the result will be 500.

Interview answer

COUNT is an aggregate function used to count records or non-NULL values.

42. COUNT(*)
Definition

COUNT(*) counts all rows in a table.

Query
SELECT COUNT(*) AS total_records
FROM guidein_dataset;
Output
total_records
500
Important

COUNT(*) counts every row, including rows containing NULL values.

43. COUNT(column)
Definition

COUNT(column) counts only the non-NULL values in that column.

Example:

SELECT COUNT(service) AS service_count
FROM guidein_dataset;
Output
service_count
490

If 10 records have service = NULL, they are not counted.

Important difference
COUNT(*)

counts rows.

COUNT(service)

counts non-NULL service values.

44. COUNT(DISTINCT)
Definition

COUNT(DISTINCT column) counts the unique non-NULL values.

Example

Count unique users:

SELECT COUNT(DISTINCT user_id) AS unique_users
FROM guidein_dataset;
Output
unique_users
500

If the same user appears multiple times:

user_id
101
101
102
103
103

then:

COUNT(DISTINCT user_id)

returns:

3

because the unique users are:

101, 102, 103
45. SUM()
Definition

SUM() calculates the total of numeric values.

GuideIn is especially suitable for this because funnel columns contain 1 and 0.

For example:

visited = 1 → user visited
visited = 0 → user did not visit
Example
SELECT SUM(visited) AS total_visitors
FROM guidein_dataset;
Output
total_visitors
450

Because:

1 + 1 + 1 + 0 + 1 + ...
= 450
SUM() FOR REGISTRATIONS
SELECT SUM(registered) AS total_registered
FROM guidein_dataset;
Output
total_registered
320
SUM() FOR LOGINS
SELECT SUM(logged_in) AS total_logged_in
FROM guidein_dataset;
Output
total_logged_in
250
SUM() FOR SUBSCRIPTIONS
SELECT SUM(subscribed) AS total_subscribed
FROM guidein_dataset;
Output
total_subscribed
120
46. AVG()
Definition

AVG() calculates the average value of a numeric column.

Example

Suppose we have:

visited
1
1
0
1
0

Then:

SELECT AVG(visited) AS average_visited
FROM guidein_dataset;

The result is the average of the values.

Output
average_visited
0.90

If 90% of records have visited = 1, the average is 0.90.

GuideIn interpretation

Because the column uses 1 and 0:

AVG(visited) × 100

can represent the percentage of records where visited = 1.

Example:

SELECT
    ROUND(AVG(visited) * 100, 2) AS visitor_percentage
FROM guidein_dataset;
Output
visitor_percentage
90.00
47. MIN()
Definition

MIN() returns the smallest value.

Example

Find the earliest visit date:

SELECT MIN(visit_date) AS first_visit_date
FROM guidein_dataset;
Output
first_visit_date
2026-01-01

You can also use it with numbers:

SELECT MIN(user_id) AS minimum_user_id
FROM guidein_dataset;
Output
minimum_user_id
1
48. MAX()
Definition

MAX() returns the largest value.

Example

Find the latest visit date:

SELECT MAX(visit_date) AS last_visit_date
FROM guidein_dataset;
Output
last_visit_date
2026-09-16

Find the largest user ID:

SELECT MAX(user_id) AS maximum_user_id
FROM guidein_dataset;
Output
maximum_user_id
500
49. AGGREGATE FUNCTIONS WITH GROUP BY

This is where aggregate functions become very useful for business analysis.

COUNT + GROUP BY
Question

How many users are there for each service?

SELECT
    service,
    COUNT(*) AS total_users
FROM guidein_dataset
GROUP BY service;
Output
service	total_users
Basic	180
Premium	220
Enterprise	100
SUM + GROUP BY
Question

How many users visited from each source?

SELECT
    source,
    SUM(visited) AS visitors
FROM guidein_dataset
GROUP BY source;
Output
source	visitors
Google	150
Facebook	120
Instagram	100
LinkedIn	50
Direct	30
SUM + GROUP BY FOR REGISTRATION
SELECT
    source,
    SUM(registered) AS registered_users
FROM guidein_dataset
GROUP BY source;
Output
source	registered_users
Google	110
Facebook	85
Instagram	70
LinkedIn	35
Direct	20
SUM + GROUP BY FOR SUBSCRIPTIONS
SELECT
    source,
    SUM(subscribed) AS subscribers
FROM guidein_dataset
GROUP BY source;
Output
source	subscribers
Google	45
Facebook	30
Instagram	25
LinkedIn	12
Direct	8
MULTIPLE AGGREGATE FUNCTIONS

You can use multiple aggregate functions in the same query.

Example
SELECT
    COUNT(*) AS total_records,
    SUM(visited) AS visitors,
    SUM(registered) AS registered_users,
    SUM(logged_in) AS logged_in_users,
    SUM(subscribed) AS subscribed_users
FROM guidein_dataset;
Output
total_records	visitors	registered_users	logged_in_users	subscribed_users
500	450	320	250	120

This is a simple GuideIn funnel KPI query.

COUNT + DISTINCT + GROUP BY
Question

How many unique users are associated with each service?

SELECT
    service,
    COUNT(DISTINCT user_id) AS unique_users
FROM guidein_dataset
GROUP BY service;
Output
service	unique_users
Basic	180
Premium	220
Enterprise	100
MIN + MAX TOGETHER
Question

What is the date range of the GuideIn data?

SELECT
    MIN(visit_date) AS first_date,
    MAX(visit_date) AS last_date
FROM guidein_dataset;
Output
first_date	last_date
2026-01-01	2026-09-16
AVG + GROUP BY
Example
SELECT
    service,
    ROUND(AVG(subscribed) * 100, 2) AS subscription_percentage
FROM guidein_dataset
GROUP BY service;
Output
service	subscription_percentage
Basic	15.00
Premium	30.00
Enterprise	22.00

This works because:

subscribed = 1 → subscribed
subscribed = 0 → not subscribed

Therefore:

AVG(subscribed) × 100

represents the percentage of rows with subscribed = 1.

CONDITIONAL AGGREGATION

This is an important SQL data-analysis technique.

Instead of simply:

SUM(visited)

you can use:

SUM(CASE WHEN visited = 1 THEN 1 ELSE 0 END)
Example
SELECT
    SUM(CASE
        WHEN registered = 1 THEN 1
        ELSE 0
    END) AS registered_users
FROM guidein_dataset;
Output
registered_users
320
COMPLETE FUNNEL USING AGGREGATION
SELECT
    COUNT(DISTINCT user_id) AS total_users,

    SUM(CASE
        WHEN visited = 1 THEN 1
        ELSE 0
    END) AS visitors,

    SUM(CASE
        WHEN registered = 1 THEN 1
        ELSE 0
    END) AS registered_users,

    SUM(CASE
        WHEN logged_in = 1 THEN 1
        ELSE 0
    END) AS logged_in_users,

    SUM(CASE
        WHEN subscribed = 1 THEN 1
        ELSE 0
    END) AS subscribed_users

FROM guidein_dataset;
Output
total_users	visitors	registered_users	logged_in_users	subscribed_users
500	450	320	250	120
CONVERSION RATE WITH AGGREGATE FUNCTIONS
Visit → Registration
SELECT
    ROUND(
        SUM(registered) * 100.0 /
        NULLIF(SUM(visited), 0),
        2
    ) AS visit_to_register_rate
FROM guidein_dataset;
Output
visit_to_register_rate
71.11

Calculation:

320 / 450 × 100
= 71.11%
REGISTER → LOGIN
SELECT
    ROUND(
        SUM(logged_in) * 100.0 /
        NULLIF(SUM(registered), 0),
        2
    ) AS register_to_login_rate
FROM guidein_dataset;
Output
register_to_login_rate
78.13
LOGIN → SUBSCRIBE
SELECT
    ROUND(
        SUM(subscribed) * 100.0 /
        NULLIF(SUM(logged_in), 0),
        2
    ) AS login_to_subscribe_rate
FROM guidein_dataset;
Output
login_to_subscribe_rate
48.00
ALL AGGREGATE FUNCTIONS — SUMMARY
Function	Purpose
COUNT()	Count values/records
COUNT(*)	Count all rows
COUNT(column)	Count non-NULL values
COUNT(DISTINCT)	Count unique values
SUM()	Calculate total
AVG()	Calculate average
MIN()	Find minimum
MAX()	Find maximum
INTERVIEW QUESTIONS
Q1. What are aggregate functions?

Aggregate functions perform calculations on multiple rows and return a single result, such as COUNT, SUM, AVG, MIN, and MAX.

Q2. Difference between COUNT(*) and COUNT(column)?

COUNT(*) counts all rows, while COUNT(column) counts only non-NULL values in that column.

Q3. What is COUNT(DISTINCT)?

It counts unique non-NULL values in a column.

Q4. What does SUM do?

SUM calculates the total of numeric values.

Q5. What does AVG do?

AVG calculates the average of numeric values.

Q6. What is MIN?

MIN returns the smallest value from a column.

Q7. What is MAX?

MAX returns the largest value from a column.

Q8. Can aggregate functions be used with GROUP BY?

Yes. GROUP BY is commonly used with aggregate functions to calculate metrics for each group.

Q9. What is conditional aggregation?

Conditional aggregation combines aggregate functions with conditions, commonly using CASE WHEN, to calculate specific business metrics.

Example:

SELECT
    SUM(CASE WHEN subscribed = 1 THEN 1 ELSE 0 END)
FROM guidein_dataset;
PRACTICE QUESTIONS

Try writing these yourself:

Practice 1

Find the total number of records.

Practice 2

Find the total number of unique users.

Practice 3

Find the total visitors.

Practice 4

Find the total registered users.

Practice 5

Find the total logged-in users.

Practice 6

Find the total subscribers.

Practice 7

Find the number of users for each service.

Practice 8

Find the number of subscribers for each service.

Practice 9

Find the number of visitors for each source.

Practice 10

Find the earliest and latest visit dates.

Practice 11

Calculate the visit-to-registration conversion rate.

Practice 12

Calculate the login-to-subscription conversion rate.

MODULE 4 COMPLETE ✅

You have learned:

COUNT → COUNT(*) → COUNT(column) → COUNT(DISTINCT) → SUM → AVG → MIN → MAX → GROUP BY + Aggregates → Conditional Aggregation → Funnel KPIs → Conversion Rates
