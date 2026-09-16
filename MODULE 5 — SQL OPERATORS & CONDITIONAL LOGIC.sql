MODULE 5 — SQL OPERATORS & CONDITIONAL LOGIC

This module covers:

Arithmetic Operators → Comparison Operators → Logical Operators → CASE → WHEN → THEN → ELSE → END → CASE in SELECT → CASE with GROUP BY → Conditional Aggregation

We will continue with your GuideIn dataset.

50. ARITHMETIC OPERATORS
Definition

Arithmetic operators are used to perform mathematical calculations in SQL.

Operator	Meaning
+	Addition
-	Subtraction
*	Multiplication
/	Division
%	Modulus/remainder
+ Addition
Example
SELECT
    10 + 5 AS result;
Output
result
15
- Subtraction
SELECT
    10 - 5 AS result;
Output
result
5
* Multiplication
SELECT
    10 * 5 AS result;
Output
result
50
/ Division
SELECT
    10 / 5 AS result;
Output
result
2.0000
% Modulus

Returns the remainder.

SELECT
    10 % 3 AS remainder;
Output
remainder
1
51. COMPARISON OPERATORS

You already learned these in Module 2, but they are important when using conditional logic.

Operator	Meaning
=	Equal
!=	Not equal
<>	Not equal
>	Greater than
<	Less than
>=	Greater than or equal
<=	Less than or equal

Example:

SELECT *
FROM guidein_dataset
WHERE subscribed = 1;
52. LOGICAL OPERATORS

Logical operators combine conditions.

Operator	Meaning
AND	All conditions must be true
OR	At least one condition must be true
NOT	Reverses a condition

Example:

SELECT *
FROM guidein_dataset
WHERE visited = 1
AND registered = 1;
53. CASE
Definition

CASE allows you to create conditional logic in SQL.

It is similar to:

IF condition
THEN result
ELSE result
Basic syntax
CASE
    WHEN condition THEN result
    ELSE result
END
54. WHEN

WHEN specifies the condition that SQL should check.

Example:

CASE
    WHEN subscribed = 1 THEN 'Subscribed'
END
55. THEN

THEN specifies what should be returned when the WHEN condition is true.

Example:

CASE
    WHEN subscribed = 1 THEN 'Subscribed'
END

If:

subscribed = 1

the result is:

Subscribed
56. ELSE

ELSE specifies what should happen when none of the WHEN conditions are true.

Example:

CASE
    WHEN subscribed = 1 THEN 'Subscribed'
    ELSE 'Not Subscribed'
END
57. END

END marks the end of the CASE expression.

Complete structure:

CASE
    WHEN condition THEN result
    ELSE result
END
58. CASE WITH SELECT

This is one of the most useful SQL techniques.

Business question

Show whether each user subscribed or not.

Query
SELECT
    user_id,
    subscribed,
    CASE
        WHEN subscribed = 1 THEN 'Subscribed'
        ELSE 'Not Subscribed'
    END AS subscription_status
FROM guidein_dataset;
Output
user_id	subscribed	subscription_status
1	1	Subscribed
2	0	Not Subscribed
3	0	Not Subscribed
4	1	Subscribed
5	0	Not Subscribed
MULTIPLE WHEN CONDITIONS

You can have multiple WHEN conditions.

GuideIn funnel stage
SELECT
    user_id,
    CASE
        WHEN subscribed = 1 THEN 'Subscribed'
        WHEN logged_in = 1 THEN 'Logged In'
        WHEN registered = 1 THEN 'Registered'
        WHEN visited = 1 THEN 'Visited'
        ELSE 'No Activity'
    END AS funnel_stage
FROM guidein_dataset;
Output
user_id	funnel_stage
1	Subscribed
2	Logged In
3	Registered
4	Visited
5	No Activity
Important

The order matters.

SQL checks the conditions from top to bottom and returns the first matching condition.

59. CASE WITH GROUP BY

You can use CASE to create categories and then group them.

Example

Count subscribed and non-subscribed users:

SELECT
    CASE
        WHEN subscribed = 1 THEN 'Subscribed'
        ELSE 'Not Subscribed'
    END AS subscription_status,
    COUNT(*) AS total_users
FROM guidein_dataset
GROUP BY
    CASE
        WHEN subscribed = 1 THEN 'Subscribed'
        ELSE 'Not Subscribed'
    END;
Output
subscription_status	total_users
Subscribed	120
Not Subscribed	380
CASE WITH SERVICE
Business question

Categorize Premium users separately.

SELECT
    user_id,
    service,
    CASE
        WHEN service = 'Premium' THEN 'Premium User'
        ELSE 'Other User'
    END AS user_category
FROM guidein_dataset;
Output
user_id	service	user_category
1	Premium	Premium User
2	Basic	Other User
3	Enterprise	Other User
4	Premium	Premium User
CASE WITH NUMERIC CONDITIONS

You can also use numbers.

Example

Create user ID categories:

SELECT
    user_id,
    CASE
        WHEN user_id <= 100 THEN 'Group 1'
        WHEN user_id <= 200 THEN 'Group 2'
        ELSE 'Group 3'
    END AS user_group
FROM guidein_dataset;
Output
user_id	user_group
50	Group 1
150	Group 2
250	Group 3
CONDITIONAL AGGREGATION

This is very important for your GuideIn project.

Definition

Conditional aggregation means using conditions inside aggregate functions such as SUM() or COUNT().

The most common pattern is:

SUM(
    CASE
        WHEN condition THEN 1
        ELSE 0
    END
)
COUNT VISITORS
SELECT
    SUM(
        CASE
            WHEN visited = 1 THEN 1
            ELSE 0
        END
    ) AS total_visitors
FROM guidein_dataset;
Output
total_visitors
450
COUNT REGISTERED USERS
SELECT
    SUM(
        CASE
            WHEN registered = 1 THEN 1
            ELSE 0
        END
    ) AS total_registered
FROM guidein_dataset;
Output
total_registered
320
COUNT LOGGED-IN USERS
SELECT
    SUM(
        CASE
            WHEN logged_in = 1 THEN 1
            ELSE 0
        END
    ) AS total_logged_in
FROM guidein_dataset;
Output
total_logged_in
250
COUNT SUBSCRIBERS
SELECT
    SUM(
        CASE
            WHEN subscribed = 1 THEN 1
            ELSE 0
        END
    ) AS total_subscribers
FROM guidein_dataset;
Output
total_subscribers
120
MULTIPLE CONDITIONAL AGGREGATIONS

This is a very useful real-world query.

SELECT
    SUM(CASE WHEN visited = 1 THEN 1 ELSE 0 END) AS visitors,
    SUM(CASE WHEN registered = 1 THEN 1 ELSE 0 END) AS registered_users,
    SUM(CASE WHEN logged_in = 1 THEN 1 ELSE 0 END) AS logged_in_users,
    SUM(CASE WHEN subscribed = 1 THEN 1 ELSE 0 END) AS subscribers
FROM guidein_dataset;
Output
visitors	registered_users	logged_in_users	subscribers
450	320	250	120
CONDITIONAL AGGREGATION BY SOURCE
Business question

How many visitors, registered users, logged-in users, and subscribers came from each source?

SELECT
    source,

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
    END) AS subscribers

FROM guidein_dataset

GROUP BY source;
Output
source	visitors	registered_users	logged_in_users	subscribers
Google	150	110	85	45
Facebook	120	85	65	30
Instagram	100	70	55	25
LinkedIn	50	35	30	12
Direct	30	20	15	8
CONDITIONAL AGGREGATION BY SERVICE
SELECT
    service,

    SUM(CASE WHEN visited = 1 THEN 1 ELSE 0 END) AS visitors,

    SUM(CASE WHEN registered = 1 THEN 1 ELSE 0 END) AS registered_users,

    SUM(CASE WHEN logged_in = 1 THEN 1 ELSE 0 END) AS logged_in_users,

    SUM(CASE WHEN subscribed = 1 THEN 1 ELSE 0 END) AS subscribers

FROM guidein_dataset
GROUP BY service;
Output
service	visitors	registered_users	logged_in_users	subscribers
Basic	170	140	100	50
Premium	210	150	120	55
Enterprise	70	30	30	15
CASE FOR FUNNEL DROP-OFF

This is directly related to your project.

Business question

Identify the user's current funnel stage.

SELECT
    user_id,

    CASE
        WHEN subscribed = 1
            THEN 'Subscribed'

        WHEN logged_in = 1
            THEN 'Logged In - Not Subscribed'

        WHEN registered = 1
            THEN 'Registered - Not Logged In'

        WHEN visited = 1
            THEN 'Visited - Not Registered'

        ELSE 'No Activity'
    END AS funnel_stage

FROM guidein_dataset;
Output
user_id	funnel_stage
1	Subscribed
2	Logged In - Not Subscribed
3	Registered - Not Logged In
4	Visited - Not Registered
5	No Activity
CASE + GROUP BY FOR FUNNEL ANALYSIS
SELECT
    CASE
        WHEN subscribed = 1 THEN 'Subscribed'
        WHEN logged_in = 1 THEN 'Logged In'
        WHEN registered = 1 THEN 'Registered'
        WHEN visited = 1 THEN 'Visited'
        ELSE 'No Activity'
    END AS funnel_stage,

    COUNT(*) AS users

FROM guidein_dataset

GROUP BY
    CASE
        WHEN subscribed = 1 THEN 'Subscribed'
        WHEN logged_in = 1 THEN 'Logged In'
        WHEN registered = 1 THEN 'Registered'
        WHEN visited = 1 THEN 'Visited'
        ELSE 'No Activity'
    END;
Output
funnel_stage	users
Subscribed	120
Logged In	130
Registered	70
Visited	130
No Activity	50
CASE + ORDER BY

You can also sort based on calculated categories.

SELECT
    user_id,
    CASE
        WHEN subscribed = 1 THEN 'Subscribed'
        WHEN registered = 1 THEN 'Registered'
        ELSE 'Visitor'
    END AS user_status
FROM guidein_dataset
ORDER BY user_status;
CASE FOR CONVERSION STATUS
SELECT
    user_id,
    visited,
    registered,
    CASE
        WHEN visited = 1 AND registered = 1
            THEN 'Converted'

        WHEN visited = 1 AND registered = 0
            THEN 'Dropped Before Registration'

        ELSE 'Not Visited'
    END AS registration_status

FROM guidein_dataset;
Output
user_id	visited	registered	registration_status
1	1	1	Converted
2	1	0	Dropped Before Registration
3	1	1	Converted
4	0	0	Not Visited
IMPORTANT PATTERN TO REMEMBER

For GuideIn analysis, remember:

SUM(
    CASE
        WHEN condition THEN 1
        ELSE 0
    END
)

For example:

SUM(CASE WHEN subscribed = 1 THEN 1 ELSE 0 END)

means:

Count the users whose subscribed value is 1.

INTERVIEW QUESTIONS
Q1. What is CASE in SQL?

CASE is used to implement conditional logic in SQL. It allows us to return different values based on different conditions.

Q2. What are WHEN, THEN and ELSE?

WHEN defines the condition, THEN defines the result when the condition is true, and ELSE defines the result when none of the conditions are true.

Q3. Can we have multiple WHEN conditions?

Yes. We can have multiple WHEN conditions, and SQL returns the result for the first matching condition.

Q4. What is conditional aggregation?

Conditional aggregation means applying a condition inside an aggregate function, commonly using SUM with CASE WHEN.

Q5. Give an example of conditional aggregation.
SELECT
    SUM(CASE WHEN subscribed = 1 THEN 1 ELSE 0 END) AS subscribers
FROM guidein_dataset;

This counts users whose subscription status is 1.

Q6. Why is CASE useful in data analysis?

CASE helps create categories, classify records, identify business conditions, and calculate conditional metrics.

PRACTICE QUESTIONS

Try these yourself:

Practice 1

Create a column called subscription_status.

Expected:

1 → Subscribed
0 → Not Subscribed
Practice 2

Create a login_status column.

Expected:

1 → Logged In
0 → Not Logged In
Practice 3

Count subscribers using conditional aggregation.

Practice 4

Count registered users using conditional aggregation.

Practice 5

Show visitors and non-visitors using CASE.

Practice 6

Create a funnel-stage column.

Practice 7

Count users in each funnel stage.

Practice 8

Calculate visitors by source using conditional aggregation.

Practice 9

Calculate subscribers by service using conditional aggregation.

Practice 10

Identify users who visited but did not register.

MODULE 5 COMPLETE ✅

You learned:

Arithmetic Operators → Comparison Operators → Logical Operators → CASE → WHEN → THEN → ELSE → END → CASE with SELECT → Multiple CASE Conditions → CASE with GROUP BY → Conditional Aggregation → Funnel Classification → Drop-off Classification
