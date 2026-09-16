MODULE 6 — SQL STRING FUNCTIONS

String functions are used to combine, format, clean, extract, and replace text values.

For the GuideIn project, they can be useful for columns such as:

service
source
device
60. CONCAT()
Definition

CONCAT() combines two or more text values into one string.

Syntax
CONCAT(value1, value2, value3)
Example
SELECT
    user_id,
    CONCAT(source, ' - ', device) AS source_device
FROM guidein_dataset;
Example output
user_id	source_device
1	Google - Mobile
2	Facebook - Desktop
3	Instagram - Mobile
Interview answer

CONCAT() is used to combine multiple string values into a single string.

Example: Combining source and device into Google - Mobile.

61. CONCAT_WS()
Definition

CONCAT_WS() means Concatenate With Separator.

It combines multiple values and automatically places a separator between them.

Syntax
CONCAT_WS('separator', value1, value2, value3)
Example
SELECT
    user_id,
    CONCAT_WS(' | ', source, service, device) AS user_details
FROM guidein_dataset;
Example output
user_id	user_details
1	Google | Premium | Mobile
2	Facebook | Basic | Desktop
Interview answer

CONCAT_WS() combines multiple strings using a specified separator.

Difference:

CONCAT(source, ' - ', device)

You manually provide the separator.

CONCAT_WS(' - ', source, device)

SQL adds the separator between values.

62. UPPER()
Definition

UPPER() converts text into uppercase letters.

Syntax
UPPER(column_name)
Example
SELECT
    user_id,
    UPPER(source) AS source_upper
FROM guidein_dataset;
Example output
user_id	source_upper
1	GOOGLE
2	FACEBOOK
3	INSTAGRAM
Interview answer

UPPER() converts a string into uppercase. It is useful for standardizing text values.

63. LOWER()
Definition

LOWER() converts text into lowercase letters.

Syntax
LOWER(column_name)
Example
SELECT
    user_id,
    LOWER(device) AS device_lower
FROM guidein_dataset;
Example output
user_id	device_lower
1	mobile
2	desktop
3	mobile
Interview answer

LOWER() converts text into lowercase and can be used to standardize text data.

64. LENGTH()
Definition

LENGTH() returns the number of bytes in a string.

For ordinary English/ASCII text, this generally corresponds to the number of characters.

Syntax
LENGTH(column_name)
Example
SELECT
    user_id,
    service,
    LENGTH(service) AS service_length
FROM guidein_dataset;
Example output
user_id	service	service_length
1	Premium	7
2	Basic	5
3	Enterprise	10
Interview answer

LENGTH() returns the length of a string in bytes. For standard English text, it normally matches the character count.

65. TRIM()
Definition

TRIM() removes leading and trailing spaces from a string.

Syntax
TRIM(column_name)
Example
SELECT
    user_id,
    TRIM(source) AS cleaned_source
FROM guidein_dataset;

If the data contains:

'  Google  '

The result becomes:

'Google'
Interview answer

TRIM() removes unnecessary spaces from the beginning and end of a string.

Common use: data cleaning.

66. LTRIM()
Definition

LTRIM() removes spaces from the left/beginning of a string.

Syntax
LTRIM(column_name)
Example
SELECT
    user_id,
    LTRIM(source) AS cleaned_source
FROM guidein_dataset;

Example:

'   Google'

becomes:

'Google'
Interview answer

LTRIM() removes leading spaces from a string.

67. RTRIM()
Definition

RTRIM() removes spaces from the right/end of a string.

Syntax
RTRIM(column_name)
Example
SELECT
    user_id,
    RTRIM(source) AS cleaned_source
FROM guidein_dataset;

Example:

'Google   '

becomes:

'Google'
Interview answer

RTRIM() removes trailing spaces from a string.

68. SUBSTRING()
Definition

SUBSTRING() extracts a part of a string.

Syntax
SUBSTRING(string, start_position, length)
Example
SELECT
    user_id,
    source,
    SUBSTRING(source, 1, 3) AS source_short
FROM guidein_dataset;
Example output
user_id	source	source_short
1	Google	Goo
2	Facebook	Fac
3	Instagram	Ins
How it works

For:

Google

Positions are:

G o o g l e
1 2 3 4 5 6
SUBSTRING('Google', 1, 3)

returns:

Goo
Interview answer

SUBSTRING() extracts a specific portion of a string based on the starting position and length.

69. LEFT()
Definition

LEFT() returns a specified number of characters from the left side of a string.

Syntax
LEFT(string, number_of_characters)
Example
SELECT
    user_id,
    source,
    LEFT(source, 3) AS source_prefix
FROM guidein_dataset;
Example output
user_id	source	source_prefix
1	Google	Goo
2	Facebook	Fac
3	Instagram	Ins
Interview answer

LEFT() extracts a specified number of characters from the beginning of a string.

70. RIGHT()
Definition

RIGHT() returns a specified number of characters from the right side of a string.

Syntax
RIGHT(string, number_of_characters)
Example
SELECT
    user_id,
    source,
    RIGHT(source, 3) AS source_suffix
FROM guidein_dataset;
Example output
user_id	source	source_suffix
1	Google	gle
2	Facebook	ook
3	Instagram	ram
Interview answer

RIGHT() extracts a specified number of characters from the end of a string.

71. REPLACE()
Definition

REPLACE() searches for specific text and replaces it with another text.

Syntax
REPLACE(string, old_text, new_text)
Example

Suppose we want to change:

Google

to:

Google Ads

Query:

SELECT
    user_id,
    source,
    REPLACE(source, 'Google', 'Google Ads') AS updated_source
FROM guidein_dataset;
Example output
user_id	source	updated_source
1	Google	Google Ads
2	Facebook	Facebook
3	Instagram	Instagram
Interview answer

REPLACE() searches for a specific substring and replaces it with another value.

🔥 Important String Functions Summary
Function	Purpose
CONCAT()	Combine strings
CONCAT_WS()	Combine strings with separator
UPPER()	Convert to uppercase
LOWER()	Convert to lowercase
LENGTH()	Find string length in bytes
TRIM()	Remove leading and trailing spaces
LTRIM()	Remove left spaces
RTRIM()	Remove right spaces
SUBSTRING()	Extract part of string
LEFT()	Extract from left
RIGHT()	Extract from right
REPLACE()	Replace text
⭐ Real-Time GuideIn Data Cleaning Query

You can combine multiple string functions:

SELECT
    user_id,
    UPPER(TRIM(source)) AS cleaned_source,
    LOWER(TRIM(device)) AS cleaned_device,
    TRIM(service) AS cleaned_service
FROM guidein_dataset;

This performs basic text standardization:

Remove unnecessary spaces
        ↓
TRIM()
        ↓
Standardize capitalization
        ↓
UPPER() / LOWER()
⭐ Interview Scenario
Question:

You receive source data with inconsistent spaces and capitalization. How would you clean it using SQL?

Answer:

I would use string functions such as TRIM(), UPPER(), and LOWER() to clean and standardize the text.

Example:

SELECT
    TRIM(source) AS cleaned_source,
    UPPER(TRIM(device)) AS cleaned_device
FROM guidein_dataset;
📝 MODULE 6 PRACTICE

Try these yourself before looking for the solution.

Q1

Display source in uppercase.

Q2

Display device in lowercase.

Q3

Find the length of each service.

Q4

Remove spaces from source.

Q5

Display the first 3 characters of service.

Q6

Display the last 3 characters of source.

Q7

Combine source and device using -.

Expected format:

Google - Mobile
Q8

Combine source, service, and device using |.

Q9

Replace Google with Google Ads in the source column.

Q10 — Interview level

Create a query that displays:

user_id
cleaned_source
cleaned_device
service_length

using appropriate string functions.

✅ MODULE 6 COMPLETE

Covered:

CONCAT → CONCAT_WS → UPPER → LOWER → LENGTH → TRIM → LTRIM → RTRIM → SUBSTRING → LEFT → RIGHT → REPLACE
