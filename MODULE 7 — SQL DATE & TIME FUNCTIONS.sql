MODULE 7 — SQL DATE & TIME FUNCTIONS

Date and time functions are used to filter, extract, format, compare, and analyze dates.

For the GuideIn project, the main date column is:

visit_date

We will learn:

72 → Date Data Types
73 → CURDATE()
74 → NOW()
75 → YEAR()
76 → MONTH()
77 → DAY()
78 → DATE_FORMAT()
79 → DATEDIFF()
80 → Date Filtering
81 → Daily Analysis
82 → Monthly Analysis
83 → Yearly Analysis

72. DATE DATA TYPES
Definition

SQL provides different data types for storing date and time information.

The important MySQL types are:

Data Type	Stores	Example
DATE	Date only	2026-09-17
DATETIME	Date + time	2026-09-17 14:30:00
TIMESTAMP	Date + time	2026-09-17 14:30:00
TIME	Time only	14:30:00
YEAR	Year	2026

For our GuideIn table:

visit_date DATE

means visit_date stores a date without a time.

Example
SELECT user_id, visit_date
FROM guidein_dataset;
Example output
user_id	visit_date
1	2026-01-05
2	2026-01-06
3	2026-01-07

These are illustrative outputs, not claimed values from your actual dataset.

Interview answer

DATE stores a calendar date in MySQL, usually in YYYY-MM-DD format. In the GuideIn project, I use it for the user's visit date.

73. CURDATE()
Definition

CURDATE() returns the current date.

Syntax
CURDATE()
Example
SELECT CURDATE() AS today;
Example output
today
2026-09-17

The exact result changes according to the date when the query is executed.

Interview answer

CURDATE() returns the current date.

74. NOW()
Definition

NOW() returns the current date and time.

Syntax
NOW()
Example
SELECT NOW() AS current_datetime;
Example output
current_datetime
2026-09-17 17:30:00

The displayed time will depend on when you execute the query.

Difference
CURDATE()

returns:

2026-09-17

while:

NOW()

returns:

2026-09-17 17:30:00
Interview answer

NOW() returns the current date and time, while CURDATE() returns only the current date.

75. YEAR()
Definition

YEAR() extracts the year from a date.

Syntax
YEAR(date_column)
Example
SELECT
    user_id,
    visit_date,
    YEAR(visit_date) AS visit_year
FROM guidein_dataset;
Example output
user_id	visit_date	visit_year
1	2026-01-05	2026
2	2026-02-10	2026
3	2025-12-20	2025
Interview answer

YEAR() extracts the year portion from a date. It is useful for yearly analysis.

76. MONTH()
Definition

MONTH() extracts the month number from a date.

Syntax
MONTH(date_column)
Example
SELECT
    user_id,
    visit_date,
    MONTH(visit_date) AS visit_month
FROM guidein_dataset;
Example output
user_id	visit_date	visit_month
1	2026-01-05	1
2	2026-02-10	2
3	2026-09-17	9
Interview answer

MONTH() extracts the month number from a date. I can use it to perform monthly analysis.

77. DAY()
Definition

DAY() extracts the day of the month from a date.

Syntax
DAY(date_column)
Example
SELECT
    user_id,
    visit_date,
    DAY(visit_date) AS visit_day
FROM guidein_dataset;
Example output
user_id	visit_date	visit_day
1	2026-01-05	5
2	2026-02-10	10
3	2026-09-17	17
Interview answer

DAY() extracts the day of the month from a date.

78. DATE_FORMAT()
Definition

DATE_FORMAT() changes a date into a desired display format.

Syntax
DATE_FORMAT(date, format)
Common formats
Format	Meaning
%Y	4-digit year
%y	2-digit year
%m	Month number
%M	Full month name
%d	Day
%W	Full weekday name
Example 1 — Month and Year
SELECT
    user_id,
    visit_date,
    DATE_FORMAT(visit_date, '%M %Y') AS month_year
FROM guidein_dataset;
Example output
user_id	visit_date	month_year
1	2026-01-05	January 2026
2	2026-02-10	February 2026
3	2026-09-17	September 2026
Example 2 — Different format
SELECT
    DATE_FORMAT(visit_date, '%d-%m-%Y') AS formatted_date
FROM guidein_dataset;

Example:

05-01-2026
10-02-2026
17-09-2026
Interview answer

DATE_FORMAT() formats a date into a specific presentation format. It is useful when displaying dates in reports.

79. DATEDIFF()
Definition

DATEDIFF() calculates the difference between two dates in days.

Syntax
DATEDIFF(date1, date2)

It calculates:

date1 - date2
Example
SELECT
    DATEDIFF('2026-09-17', '2026-09-10') AS days_difference;
Output
days_difference
7
GuideIn example
SELECT
    user_id,
    visit_date,
    DATEDIFF(CURDATE(), visit_date) AS days_since_visit
FROM guidein_dataset;

This can show approximately how many days have passed since each recorded visit.

Interview answer

DATEDIFF() calculates the difference between two dates in days. It can be used to analyze how long ago an event happened.

80. DATE FILTERING

We can use WHERE to filter records based on dates.

Example 1 — Specific date
SELECT *
FROM guidein_dataset
WHERE visit_date = '2026-09-17';

This returns records from that date.

Example 2 — After a date
SELECT *
FROM guidein_dataset
WHERE visit_date > '2026-01-01';
Example 3 — Before a date
SELECT *
FROM guidein_dataset
WHERE visit_date < '2026-06-01';
Example 4 — Date range
SELECT *
FROM guidein_dataset
WHERE visit_date BETWEEN '2026-01-01' AND '2026-03-31';

This retrieves visits between the specified dates.

Interview answer

I can filter date data using comparison operators or BETWEEN with a DATE column.

81. DAILY ANALYSIS

Daily analysis means analyzing data day by day.

Example
SELECT
    visit_date,
    COUNT(DISTINCT user_id) AS users
FROM guidein_dataset
GROUP BY visit_date
ORDER BY visit_date;
Example output
visit_date	users
2026-01-05	25
2026-01-06	31
2026-01-07	28
2026-01-08	35

These numbers are illustrative.

GuideIn business meaning

This can help identify:

Daily visitors
Daily registrations
Daily logins
Daily subscriptions
Daily changes in activity
Daily visitor analysis
SELECT
    visit_date,
    SUM(visited) AS visitors
FROM guidein_dataset
GROUP BY visit_date
ORDER BY visit_date;
Interview answer

For daily analysis, I group the data by visit_date and use aggregate functions such as COUNT() or SUM() to calculate daily metrics.

82. MONTHLY ANALYSIS

Monthly analysis groups records by month.

Basic query
SELECT
    YEAR(visit_date) AS visit_year,
    MONTH(visit_date) AS visit_month,
    COUNT(DISTINCT user_id) AS users
FROM guidein_dataset
GROUP BY
    YEAR(visit_date),
    MONTH(visit_date)
ORDER BY
    visit_year,
    visit_month;
Example output
visit_year	visit_month	users
2026	1	120
2026	2	145
2026	3	132

Numbers are illustrative.

Better report format using DATE_FORMAT()
SELECT
    DATE_FORMAT(visit_date, '%Y-%m') AS month,
    COUNT(DISTINCT user_id) AS users
FROM guidein_dataset
GROUP BY DATE_FORMAT(visit_date, '%Y-%m')
ORDER BY month;
Example output
month	users
2026-01	120
2026-02	145
2026-03	132
Interview answer

For monthly analysis, I extract the year and month from the date and group the records accordingly.

83. YEARLY ANALYSIS

Yearly analysis groups records by year.

Query
SELECT
    YEAR(visit_date) AS visit_year,
    COUNT(DISTINCT user_id) AS users
FROM guidein_dataset
GROUP BY YEAR(visit_date)
ORDER BY visit_year;
Example output
visit_year	users
2024	950
2025	1250
2026	1420

These are illustrative values.

Interview answer

For yearly analysis, I use YEAR() on the date column and group the data by year.

⭐ REAL-TIME GUIDEIN FUNNEL — MONTHLY

This is especially important for your project.

We can analyze the complete funnel month by month:

Visit
  ↓
Register
  ↓
Login
  ↓
Subscribe
Query
SELECT
    DATE_FORMAT(visit_date, '%Y-%m') AS month,

    SUM(visited) AS visitors,

    SUM(registered) AS registered_users,

    SUM(logged_in) AS logged_in_users,

    SUM(subscribed) AS subscribed_users

FROM guidein_dataset

GROUP BY DATE_FORMAT(visit_date, '%Y-%m')

ORDER BY month;
Example output
month	visitors	registered_users	logged_in_users	subscribed_users
2026-01	100	70	50	25
2026-02	120	80	60	30
2026-03	150	100	75	40

Again, these are example outputs, not actual GuideIn results.

⭐ MONTHLY CONVERSION RATE

We can also calculate monthly conversion.

SELECT
    DATE_FORMAT(visit_date, '%Y-%m') AS month,

    SUM(visited) AS visitors,

    SUM(registered) AS registrations,

    ROUND(
        SUM(registered) * 100.0 /
        NULLIF(SUM(visited), 0),
        2
    ) AS visit_to_register_rate

FROM guidein_dataset

GROUP BY DATE_FORMAT(visit_date, '%Y-%m')

ORDER BY month;
Example output
month	visitors	registrations	visit_to_register_rate
2026-01	100	70	70.00
2026-02	120	80	66.67
2026-03	150	100	66.67
Interview answer

I can combine date functions, aggregation, and conditional calculations to analyze monthly funnel performance and conversion rates.

🔥 IMPORTANT DATE FUNCTIONS
Function	Purpose
CURDATE()	Current date
NOW()	Current date and time
YEAR()	Extract year
MONTH()	Extract month
DAY()	Extract day
DATE_FORMAT()	Format a date
DATEDIFF()	Difference between dates
🎯 INTERVIEW QUESTIONS
Q1. What is CURDATE()?

Answer:

CURDATE() returns the current date.

Q2. Difference between CURDATE() and NOW()?

Answer:

CURDATE() returns only the current date, while NOW() returns the current date and time.

Q3. How do you extract the year from a date?
SELECT YEAR(visit_date)
FROM guidein_dataset;
Q4. How do you perform monthly analysis?

Answer:

I use YEAR() and MONTH() or DATE_FORMAT() and then group the records by the month.

Q5. How do you calculate the number of days between two dates?
SELECT DATEDIFF('2026-09-17', '2026-09-10');
Q6. How do you find GuideIn users who visited during a date range?
SELECT *
FROM guidein_dataset
WHERE visit_date BETWEEN '2026-01-01' AND '2026-03-31';
📝 MODULE 7 PRACTICE

Try these yourself.

Q1

Display the current date.

Q2

Display the current date and time.

Q3

Display user_id, visit_date, and the year of the visit.

Q4

Display the month number from visit_date.

Q5

Display the day from visit_date.

Q6

Format visit_date as:

January 2026
Q7

Find records where the visit date is after:

2026-01-01
Q8

Find records between:

2026-01-01

and

2026-03-31
Q9

Calculate the number of days between visit_date and today.

Q10 — Interview level

Create a query showing:

month
visitors
registered_users
logged_in_users
subscribed_users

grouped by month.

✅ MODULE 7 COMPLETE

You now know:

DATE → CURDATE → NOW → YEAR → MONTH → DAY → DATE_FORMAT → DATEDIFF → Date Filtering → Daily → Monthly → Yearly Analysis
