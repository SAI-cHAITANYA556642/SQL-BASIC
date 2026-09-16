MODULE 2 — SQL FILTERING DATA

Filtering means retrieving only the records that satisfy a condition.

We will use the GuideIn table:

guidein_dataset

Important columns:

user_id
visit_date
visited
registered
logged_in
subscribed
service
source
device
17. WHERE
Definition

WHERE is used to filter rows based on a condition.

Example

Find users who visited:

SELECT *
FROM guidein_dataset
WHERE visited = 1;
Output
user_id	visited	registered	logged_in	subscribed
1	1	1	1	1
2	1	1	0	0
3	1	0	0	0
Interview answer

WHERE is used to filter records based on a specified condition.

18. EQUAL TO =
Definition

= checks whether two values are equal.

Example

Find subscribed users:

SELECT user_id, subscribed
FROM guidein_dataset
WHERE subscribed = 1;
Output
user_id	subscribed
1	1
5	1
8	1
19. NOT EQUAL !=
Definition

!= returns records where the value is different from the specified value.

Example

Find users who did not subscribe:

SELECT user_id, subscribed
FROM guidein_dataset
WHERE subscribed != 1;
Output
user_id	subscribed
2	0
3	0
4	0

You can also use:

WHERE subscribed <> 1;
20. GREATER THAN >
Definition

> checks whether a value is greater than another value.

Example with user_id:

SELECT user_id, service
FROM guidein_dataset
WHERE user_id > 100;
Output
user_id	service
101	Basic
102	Premium
103	Premium
21. LESS THAN <
Definition

< checks whether a value is smaller than another value.

SELECT user_id, service
FROM guidein_dataset
WHERE user_id < 100;
Output
user_id	service
1	Basic
2	Premium
3	Basic
22. GREATER THAN OR EQUAL >=
Definition

Returns values greater than or equal to the specified value.

SELECT user_id
FROM guidein_dataset
WHERE user_id >= 100;
Output
user_id
100
101
102
103
23. LESS THAN OR EQUAL <=
Definition

Returns values less than or equal to the specified value.

SELECT user_id
FROM guidein_dataset
WHERE user_id <= 3;
Output
user_id
1
2
3
24. AND
Definition

AND requires all conditions to be true.

Example

Find users who visited and registered:

SELECT user_id, visited, registered
FROM guidein_dataset
WHERE visited = 1
AND registered = 1;
Output
user_id	visited	registered
1	1	1
2	1	1
5	1	1
Interview answer

AND is used when all specified conditions must be satisfied.

25. OR
Definition

OR returns records when at least one condition is true.

Example

Find users who are either registered or subscribed:

SELECT user_id, registered, subscribed
FROM guidein_dataset
WHERE registered = 1
OR subscribed = 1;
Output
user_id	registered	subscribed
1	1	1
2	1	0
5	1	1
26. NOT
Definition

NOT reverses a condition.

Example

Find users who did not subscribe:

SELECT user_id, subscribed
FROM guidein_dataset
WHERE NOT subscribed = 1;
Output
user_id	subscribed
2	0
3	0
4	0
27. IN
Definition

IN checks whether a value matches any value in a list.

Example

Find users from Google or Facebook:

SELECT user_id, source
FROM guidein_dataset
WHERE source IN ('Google', 'Facebook');
Output
user_id	source
1	Google
3	Facebook
7	Google
Instead of:
WHERE source = 'Google'
OR source = 'Facebook';

You can use:

WHERE source IN ('Google', 'Facebook');
28. NOT IN
Definition

NOT IN returns records whose value is not in the specified list.

Example
SELECT user_id, source
FROM guidein_dataset
WHERE source NOT IN ('Google', 'Facebook');
Output
user_id	source
2	Instagram
4	LinkedIn
6	Direct
29. BETWEEN
Definition

BETWEEN filters values within a specified range.

It is inclusive of the beginning and ending values.

Example

Find users with IDs between 100 and 105:

SELECT user_id
FROM guidein_dataset
WHERE user_id BETWEEN 100 AND 105;
Output
user_id
100
101
102
103
104
105
Date example
SELECT user_id, visit_date
FROM guidein_dataset
WHERE visit_date BETWEEN '2026-01-01' AND '2026-01-31';
Output
user_id	visit_date
1	2026-01-01
2	2026-01-05
3	2026-01-20
30. LIKE
Definition

LIKE is used for pattern matching, especially with text.

Example

Find sources beginning with G:

SELECT user_id, source
FROM guidein_dataset
WHERE source LIKE 'G%';
Output
user_id	source
1	Google
7	Google
31. % WILDCARD
Definition

% represents zero or more characters.

Starts with
WHERE source LIKE 'G%';

Matches:

Google
Ends with
WHERE source LIKE '%book';

Could match:

Facebook
Contains
WHERE source LIKE '%oo%';

Could match:

Google
Example
SELECT user_id, service
FROM guidein_dataset
WHERE service LIKE '%Premium%';
Output
user_id	service
2	Premium
5	Premium
8	Premium
32. _ WILDCARD
Definition

_ represents exactly one character.

Example:

SELECT source
FROM guidein_dataset
WHERE source LIKE 'G_____';

The underscore represents one character each.

For example:

Google

has six characters, so:

G + _____

matches it.

33. IS NULL
Definition

IS NULL finds records where a column has no value.

Example
SELECT *
FROM guidein_dataset
WHERE service IS NULL;
Output
user_id	service
15	NULL
28	NULL

Important: Don't use:

WHERE service = NULL;

Use:

WHERE service IS NULL;
34. IS NOT NULL
Definition

IS NOT NULL finds records where a column contains a value.

Example
SELECT *
FROM guidein_dataset
WHERE service IS NOT NULL;
Output
user_id	service
1	Basic
2	Premium
3	Basic
IMPORTANT: COMBINING FILTERS

You can combine multiple operators.

Example

Find users who:

visited
registered
but did not subscribe
SELECT
    user_id,
    visited,
    registered,
    subscribed
FROM guidein_dataset
WHERE visited = 1
AND registered = 1
AND subscribed = 0;
Output
user_id	visited	registered	subscribed
2	1	1	0
7	1	1	0
12	1	1	0

This is directly useful for GuideIn funnel drop-off analysis.

IMPORTANT SQL CONCEPT — OPERATOR SUMMARY
Operator	Meaning
=	Equal
!=	Not equal
<>	Not equal
>	Greater than
<	Less than
>=	Greater than or equal
<=	Less than or equal
AND	All conditions
OR	Any condition
NOT	Reverse condition
IN	Matches list
NOT IN	Doesn't match list
BETWEEN	Within range
LIKE	Pattern matching
%	Zero or more characters
_	One character
IS NULL	Missing value
IS NOT NULL	Value exists
INTERVIEW QUESTIONS
Q1. What is WHERE?

WHERE is used to filter rows based on a condition.

Q2. Difference between AND and OR?

AND requires all conditions to be true, while OR requires at least one condition to be true.

Q3. What is IN?

IN is used to check whether a value matches any value from a specified list.

Q4. What is BETWEEN?

BETWEEN filters values within a specified range, including the boundary values.

Q5. Can we use = NULL?

No. We use IS NULL to check for NULL values.

Q6. What is LIKE?

LIKE is used for pattern matching in text values.

Q7. What does % mean in LIKE?

% represents zero or more characters.

Q8. What does _ mean in LIKE?

_ represents exactly one character.

PRACTICE QUERIES

Try these yourself in MySQL.

Practice 1

Find all users who registered.

registered = 1
Practice 2

Find all users who logged in but did not subscribe.

Practice 3

Find users whose source is Google or Instagram.

Practice 4

Find users who visited but did not register.

Practice 5

Find records from January 2026.

Practice 6

Find services containing the word Premium.

Practice 7

Find records where device is NULL.

Practice 8

Find users with user_id between 100 and 200.

MODULE 2 COMPLETE ✅

You have now covered:

WHERE → comparison operators → AND → OR → NOT → IN → NOT IN → BETWEEN → LIKE → % → _ → IS NULL → IS NOT NULL
