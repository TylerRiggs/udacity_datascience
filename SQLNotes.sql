### Limits
/* This is a brief piece of code that selects
three columns from the web_events table and
limits to the first 15 rows
*/

SELECT ocurred_at, account_id, channel
FROM web_events
LIMIT 15;

### ORDER BY
/* This clause will allow me to sort items. The ORDER BY clause needs to go
after SELECT and FROM, but before LIMIT. Also, by default, it will display
results in "Ascending Order" which is A to Z, Low to High, or Early to Late.
To reverse the order into "DESC Order" add DESC at the end of the clause.
*/

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;

/* You can sort by multiple criteria in the ORDER BY clause */

/* A query that displays the order ID, account ID, and total dollar amount for
all the orders, sorted first by account ID (in ascending order) and then by
total dollar amount in DESC order */

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;

/* Display order ID, account ID, and total dollar amount for each order
but sorted first by total dollar amount (DESC) and then by account ID */

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id;

### WHERE

/* The WHERE clause goes after FROM but before ORDER BY. It allows us to select
a subset of data from a table when conditions are met. The most common symbols
used in WHERE statements include >, <, >=, <=, =, and != */

/* A query that pulls the first five rows and all columns from the orders table
where the dollar amount of gloss_amt_usd is greater than or equal to 1000 */

SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

/* A query that pulls the first 10 rows and all columns from the orders table
where the total_amt_usd is less than 500 */

SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;

/* Using WHERE with non-numeric data: Text needs to be in single quotes */

/* Filter the accounts table to include the company name, website, and the
primary point of contact just for Exxon Mobile in the accounts table */

SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';

### Arithmetic Operators

/* Creating a column from two or more other columns whether using Arithmetic
or other advanced calculations creates a derived column. You can give a
derived column a name by using the clause AS on the line that calculates
the column. */

/* Create a column that divides standard_amt_usd by standard_qty to find the
unit price for standard paper for each order. Limit 10 results with id and
account_id fields */

SELECT id, account_id, standard_amt_usd / standard_qty AS unit_price
FROM orders
LIMIT 10;

/* Percentage of revenue that comes from poster paper for each order. */

SELECT id, account_id, poster_amt_usd / (standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS poster_percent
FROM orders
LIMIT 10;

### Logical Operators

/* The LIKE operator is useful for working with text such as when you need
to select URLs. You would use wild cards. For example, to select all traffic
from Google, you could say

SELECT *
FROM web_events_full
WHERE referrer_url = '%google%' */

/* Selecting from accounts to find all companies whose names start with 'C' */

SELECT *
FROM accounts
WHERE name LIKE 'C%';

/* Selecting all companies whose names contain 'one' in name somewhere */

SELECT *
FROM accounts
WHERE name LIKE '%one%';

/* All companies whose names end with 's' */

SELECT *
FROM accounts
WHERE name LIKE '%s';

/* IN function: Basically an = for more than one value.

Make sure to put parenthesis around the values after IN */

/* Use accounts table to find the account name, primary_poc, and sales_rep_id
for Walmart, Target, and Nordstrom */

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');

/* NOT function: Works with IN and LIKE to give the inverse */

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%';

SELECT *
FROM accounts
WHERE name NOT LIKE '%one%';

SELECT *
FROM accounts
WHERE name NOT LIKE '%s';

/* AND and BETWEEN functions: With AND, each time you specify a statement you
need to include the column you're looking at. i.e.

SELECT *
FROM orders
WHERE occurred_at >= '2016-04-01' AND occurred_at <= '2016-10-01'
ORDER BY occurred_at;

If you use BETWEEN you don't have to specify the column both times. Instead you
could say:

WHERE occurred_at BETWEEN '2016-04-01' AND '2016-10-01' */

SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';

SELECT occurred_at, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29;

/* Note that the between values of 24 and 29 are included in the output */

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2016-12-31'
ORDER BY occurred_at DESC;

/* OR Function: */

SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

SELECT *
FROM orders
WHERE standard_qty = 0
AND (gloss_qty > 1000 OR poster_qty > 1000);

SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana')
AND primary_poc NOT LIKE '%eana%');

/*Test */
