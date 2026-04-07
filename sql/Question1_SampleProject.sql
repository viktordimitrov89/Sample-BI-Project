--Payhawk Associate BI Analyst Interview Project
--Author: Viktor Dimitrov
--Date: 07 of April 2026
-- Description: Financial analysis of company spending patterns
-- ================================================
-- Question 1: Top spending companies
-- ================================================

SELECT
companies.company_name, ROUND(SUM(transactions.amount),2) AS total_spent
FROM transactions
JOIN companies ON transactions.company_id=companies.company_id
GROUP BY transactions.company_id
ORDER BY total_spent DESC;