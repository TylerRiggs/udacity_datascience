### Aggregations

SELECT sum(poster_qty)
FROM orders;
/* 723646 */

SELECT sum(standard_qty)
FROM orders;
/* 1938346 */

SELECT sum(total_amt_usd)
FROM orders
/* 23141511.83 */

SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;

SELECT sum(standard_amt_usd) / sum(standard_qty)
FROM orders;

### Min and Max

SELECT min(occurred_at)
FROM orders;

SELECT occurred_at
FROM orders
WHERE occurred_at BETWEEN '1901-01-01' AND '2020-01-01'
LIMIT 1;

SELECT max(occurred_at)
FROM web_events

/* 1-1-2017 */

SELECT avg(standard_qty) AS AverageStandardQ, avg(poster_qty) AS AveragePosterQ, avg(glossy_qty) AS AverageGlossyQ, avg(standard_amt_usd) AS AverageStandardUSD, avg(poster_amt_usd) AS AveragePosterUSD, avg(glossy_amt_usd) AS AverageGlossyUSD
FROM orders;

### Group By

SELECT a.name AS Account, o.occurred_at AS Order_Date
FROM accounts a
JOIN orders o
ON o.account_id = a.id
ORDER BY o.occurred_at
LIMIT 1;

SELECT sum(o.total_amt_usd) AS TotalSales, a.name AS account_name
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name;

/* Which channel did the most recent web_event occur, which account was associated with the event? Query should return a date, channel and account name. */

SELECT w.channel AS channel, w.occurred_at AS time, a.name AS account
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
ORDER BY w.occurred_at DESC
LIMIT 1;

/* Two columns: Channel and number of times channel was used. */

SELECT count(*), w.channel
FROM web_events w
GROUP BY w.channel;
