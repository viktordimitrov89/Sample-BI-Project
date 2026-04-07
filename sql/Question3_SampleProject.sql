--Payhawk Associate BI Analyst Interview Project
--Author: Viktor Dimitrov
--Date: 07 of April 2026
-- Description: Financial analysis of company spending patterns
-- ================================================
-- Question 3: Budget Status by Company and Department
-- ================================================

SELECT
c.company_name,b.department, ROUND(SUM(b.allocated_budget),2) AS total_allocated_budget,
ROUND(SUM(b.spent_budget),2) AS total_spent_budgets,
CASE 
WHEN SUM(b.allocated_budget) < SUM(b.spent_budget) THEN 'Over Budget'
WHEN SUM(b.allocated_budget) *0.85<= SUM(b.spent_budget) THEN 'Near limit'
ELSE 'On Budget'
END AS spending_category
FROM budgets b
JOIN companies c ON b.company_id=c.company_id
GROUP BY c.company_name, b.department
ORDER BY c.company_name, b.department;