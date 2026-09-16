MODULE 3 — SQL SORTING & GROUPING

This module covers:

ORDER BY → ASC → DESC → GROUP BY → HAVING → WHERE vs HAVING → Grouped Business Analysis

We will continue using the GuideIn project.

35. ORDER BY
Definition

ORDER BY is used to sort the query result based on one or more columns.

Syntax
SELECT column1, column2
FROM table_name
ORDER BY column_name;
Example

Sort users by user_id:

SELECT user_id, service
FROM guidein_dataset
ORDER BY user_id;
Output
user_id	service
1	Basic
2	Premium
3	Basic
4	Premium
5	Basic

By default, sorting is ascending.

36. ASC
Definition

ASC means ascending order.

For numbers:

1 → 2 → 3 → 4 → 5

For text:

Basic → Enterprise → Premium
Example
SELECT user_id, service
FROM guidein_dataset
ORDER BY user_id ASC;
Output
user_id	service
1	Basic
2	Premium
3	Basic
4	Enterprise
5	Premium
Interview answer

ASC sorts data in ascending order. It is the default sorting order in ORDER BY.

37. DESC
Definition

DESC means descending order.

For numbers:

5 → 4 → 3 → 2 → 1
Example
SELECT user_id, service
FROM guidein_dataset
ORDER BY user_id DESC;
Output
user_id	service
5	Premium
4	Enterprise
3	Basic
2	Premium
1	Basic
SORTING BY DATE

You can also sort dates.

Example
SELECT user_id, visit_date
FROM guidein_dataset
ORDER BY visit_date ASC;
Output
user_id	visit_date
1	2026-01-01
2	2026-01-01
3	2026-01-02
4	2026-01-03
5	2026-01-05

Latest date first:

SELECT user_id, visit_date
FROM guidein_dataset
ORDER BY visit_date DESC;
SORTING BY MULTIPLE COLUMNS

You can sort using more than one column.

Example
SELECT user_id, service, source
FROM guidein_dataset
ORDER BY service ASC, user_id DESC;

First it sorts by:

service

Then, if two records have the same service, it sorts those records by:

user_id DESC
38. GROUP BY
Definition

GROUP BY groups rows having the same value so that we can perform aggregate calculations for each group.

This is extremely important for data analysis.

Example

Count users for each service:

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

The exact numbers will depend on your GuideIn dataset.

GROUP BY WITH COUNT
Definition

COUNT() counts records.

Example:

SELECT
    source,
    COUNT(*) AS total_users
FROM guidein_dataset
GROUP BY source;
Output
source	total_users
Google	150
Facebook	120
Instagram	100
LinkedIn	80
Direct	50
GROUP BY WITH SUM

Because GuideIn uses 1 and 0 for funnel stages, we can use SUM().

Example

Count visitors by source:

SELECT
    source,
    SUM(CASE WHEN visited = 1 THEN 1 ELSE 0 END) AS visitors
FROM guidein_dataset
GROUP BY source;
Output
source	visitors
Google	150
Facebook	120
Instagram	100
LinkedIn	80
Direct	50
GROUP BY MULTIPLE COLUMNS

You can group by more than one column.

Example

Analyze service and device together:

SELECT
    service,
    device,
    COUNT(*) AS total_users
FROM guidein_dataset
GROUP BY service, device;
Output
service	device	total_users
Basic	Mobile	100
Basic	Desktop	60
Basic	Tablet	20
Premium	Mobile	120
Premium	Desktop	80
Premium	Tablet	20

This is called multi-dimensional analysis.

GROUP BY + ORDER BY

You can group and then sort the result.

Example

Find services with their user counts and show the highest first:

SELECT
    service,
    COUNT(*) AS total_users
FROM guidein_dataset
GROUP BY service
ORDER BY total_users DESC;
Output
service	total_users
Premium	220
Basic	180
Enterprise	100
Interview answer

GROUP BY groups records with the same values so aggregate functions such as COUNT and SUM can be applied to each group.

39. HAVING
Definition

HAVING filters groups after GROUP BY.

This is different from WHERE.

Example

Find services having more than 100 users:

SELECT
    service,
    COUNT(*) AS total_users
FROM guidein_dataset
GROUP BY service
HAVING COUNT(*) > 100;
Output
service	total_users
Basic	180
Premium	220

Enterprise is not shown because it has only 100, and the condition is:

> 100

not:

>= 100
HAVING WITH SUM

Find sources with more than 50 subscribers:

SELECT
    source,
    SUM(CASE WHEN subscribed = 1 THEN 1 ELSE 0 END) AS subscribers
FROM guidein_dataset
GROUP BY source
HAVING SUM(CASE WHEN subscribed = 1 THEN 1 ELSE 0 END) > 50;
Output
source	subscribers
Google	75
Facebook	63
Instagram	58
40. WHERE VS HAVING

This is a very common interview question.

WHERE	HAVING
Filters rows	Filters groups
Applied before GROUP BY	Applied after GROUP BY
Normally used with individual rows	Normally used with aggregate/group results
Cannot normally use aggregate result directly	Can use aggregate functions
Example using WHERE

Find only visitors and then group them by service:

SELECT
    service,
    COUNT(*) AS visitors
FROM guidein_dataset
WHERE visited = 1
GROUP BY service;
Output
service	visitors
Basic	170
Premium	210
Enterprise	95

Here:

WHERE visited = 1

filters individual records before grouping.

Example using HAVING

Find services with more than 100 visitors:

SELECT
    service,
    COUNT(*) AS visitors
FROM guidein_dataset
WHERE visited = 1
GROUP BY service
HAVING COUNT(*) > 100;
Output
service	visitors
Basic	170
Premium	210

Here:

HAVING COUNT(*) > 100

filters the groups after grouping.

WHERE + GROUP BY + HAVING + ORDER BY

This is an important real-world SQL pattern.

Business question

Which services have more than 100 registered users, showing the highest count first?

Query
SELECT
    service,
    SUM(CASE WHEN registered = 1 THEN 1 ELSE 0 END) AS registered_users
FROM guidein_dataset
WHERE visited = 1
GROUP BY service
HAVING SUM(CASE WHEN registered = 1 THEN 1 ELSE 0 END) > 100
ORDER BY registered_users DESC;
Output
service	registered_users
Premium	180
Basic	140
SQL QUERY EXECUTION ORDER

You write:

SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
LIMIT

But SQL logically processes the query approximately in this order:

1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. ORDER BY
7. LIMIT

This is an important interview concept.

GUIDEIN BUSINESS ANALYSIS EXAMPLE
Question

How many visitors came from each source?

SELECT
    source,
    SUM(CASE WHEN visited = 1 THEN 1 ELSE 0 END) AS visitors
FROM guidein_dataset
GROUP BY source
ORDER BY visitors DESC;
Output
source	visitors
Google	150
Facebook	120
Instagram	100
LinkedIn	80
Direct	50
ANOTHER EXAMPLE
Question

How many subscribers came from each source?

SELECT
    source,
    SUM(CASE WHEN subscribed = 1 THEN 1 ELSE 0 END) AS subscribers
FROM guidein_dataset
GROUP BY source
ORDER BY subscribers DESC;
Output
source	subscribers
Google	75
Facebook	63
Instagram	58
LinkedIn	40
Direct	25
GROUP BY SERVICE + SOURCE
SELECT
    service,
    source,
    COUNT(*) AS total_users
FROM guidein_dataset
GROUP BY service, source
ORDER BY total_users DESC;
Output
service	source	total_users
Premium	Google	80
Basic	Google	70
Premium	Facebook	65
Basic	Instagram	55
Enterprise	LinkedIn	40

This type of query is useful for identifying patterns across multiple business dimensions.

INTERVIEW QUESTIONS
Q1. What is ORDER BY?

ORDER BY is used to sort query results in ascending or descending order.

Q2. What is the default ORDER BY direction?

Ascending order, or ASC.

Q3. What is GROUP BY?

GROUP BY groups records with the same values so aggregate functions can be performed on each group.

Q4. What is HAVING?

HAVING filters grouped results after GROUP BY.

Q5. What is the difference between WHERE and HAVING?

WHERE filters individual rows before grouping, while HAVING filters groups after GROUP BY.

Q6. Can we use WHERE and HAVING together?

Yes. WHERE filters rows before grouping, and HAVING filters the resulting groups.

Q7. Can GROUP BY contain multiple columns?

Yes. We can group data using multiple columns for multi-dimensional analysis.

PRACTICE

Try these without looking at the answers.

Practice 1

Find the number of users for each service.

Practice 2

Find the number of users for each source.

Practice 3

Find services in descending order of user count.

Practice 4

Find sources having more than 50 users.

Practice 5

Find registered users for each service.

Practice 6

Find subscribers for each device.

Practice 7

Find service + source combinations and their user counts.

Practice 8

Find services having more than 100 registered users.

MODULE 3 COMPLETE ✅

You learned:

ORDER BY → ASC → DESC → GROUP BY → Multiple GROUP BY → HAVING → WHERE vs HAVING → GROUP BY + Aggregate → Business Analysis Queries → SQL Execution Order
