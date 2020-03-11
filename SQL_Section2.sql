### Joins

SELECT orders.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

/* Pull all the data from the accounts table and all the data from the orders table */

SELECT *
FROM accounts
JOIN orders
ON orders.account_id = accounts.id;

SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

### Join questions

SELECT accounts.name, accounts.primary_poc, web_events.occurred_at, web_events.channel
FROM accounts
JOIN web_events
ON accounts.id = web_events.account_id
WHERE accounts.name IN ('Walmart');

SELECT sales_reps.name AS rep_name, accounts.name AS account_name, region.name AS region
FROM accounts
JOIN sales_reps
ON accounts.sales_rep_id = sales_reps.id
JOIN region
ON sales_reps.region_id = region.id
ORDER BY accounts.name;

SELECT accounts.name AS account, region.name AS region, orders.total_amt_usd / (orders.total + 0.01) AS unit_price
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
JOIN sales_reps
ON accounts.sales_rep_id = sales_reps.id
JOIN region
ON sales_reps.region_id = region.id;

###Final Check

/* region for each sales rep along with their accounts, but only for the midwest region. Final table should have three columns: region name, rep name, account name, and be sorted A-Z on account name. */

SELECT a.name AS AccountName, s.name AS SalesRepName, r.name AS RegionName
FROM sales_reps s
LEFT JOIN accounts a
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
WHERE r.name = ('Midwest')
ORDER BY a.name;

/* Table with region for each sales_rep along with their accounts, only for accounts where the sales rep first name starts with S and is in the Midwest region. Final table should include three columns: region name, sales rep name, account name, sorted by account name. */

SELECT r.name AS RegionName, s.name AS SalesRepName, a.name AS AccountName
FROM sales_reps s
LEFT JOIN accounts a
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
WHERE s.name LIKE ('S%')
ORDER BY a.name;

/* Table with region for each sales rep along with their accounts. Only for accounts where rep has last name starting with a K in the midwest region. Three columns: Region name, sales rep name, account name, sorted A-Z on account name. */

SELECT r.name AS RegionName, s.name AS SalesRepName, a.name AS Account
FROM sales_reps s
LEFT JOIN accounts a
ON a.sales_rep_id = s.id
JOIN region r
ON r.id = s.region_id
WHERE s.name LIKE ('% %K')
ORDER BY a.name;

/* Name for each region for every order, account name and the unit price they paid. Only provide results if the standard order quantity exceeds 100. Final table should have three columns: region name, account name, and unit price. */

SELECT a.name AS AccountName, r.name AS RegionName, o.total_amt_usd / (total + 0.01) AS UnitPrice
FROM accounts a
LEFT JOIN orders o
ON o.account_id = a.id
JOIN sales_reps
ON a.sales_rep_id = sales_reps.id
JOIN region r
ON r.id = sales_reps.region_id
WHERE o.standard_qty > 100;

/* Name for each region for every order as well as the account name and unit price. Standard order quantity must exceed 100 and poster order quantity must exceed 50, 3 columns, region name, account name, unit price, sorted for largest unit price first. */

SELECT r.name AS RegionName, a.name AS AccountName, o.standard_amt_usd / (o.total + 0.01) AS UnitPrice
FROM accounts a
LEFT JOIN orders o
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON r.id = s.region_id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY UnitPrice DESC;

/* Which channels are used by account 1001. Final table should have account name and channels, SELECT DISTINCT can be used to narrow down results to unique values */

SELECT a.id AS AccountID, w.channel AS channel
FROM accounts a
LEFT JOIN web_events w
ON a.id = w.account_id
WHERE a.id = 1001;

/* Find all orders in 2015, with four columns: occurred_at, account name, order total, order total_amt_usd */

SELECT a.name AS AccountName, o.total_amt_usd AS TotalDollars, o.total AS OrderTotal, w.occurred_at AS OrderDate
FROM accounts a
LEFT JOIN web_events w
ON a.id = w.account_id
LEFT JOIN orders o
ON o.account_id = a.id
WHERE w.occurred_at BETWEEN '2015-01-01' AND '2016-01-01'
ORDER BY ;
