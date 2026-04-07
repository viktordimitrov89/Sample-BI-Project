--Payhawk Associate BI Analyst Interview Project
--Author: Viktor Dimitrov
--Date: 07 of April 2026
-- Description: Financial analysis of company spending patterns
-- ================================================
-- Question 4: Declined Transactions by Company and Employee
-- ================================================

SELECT
c.company_name, e.name, t.status
FROM transactions t
JOIN companies c ON t.company_id = c.company_id
JOIN employees e ON t.card_id = e.card_id
WHERE t.status = 'Declined'
ORDER BY c.company_name, e.name;