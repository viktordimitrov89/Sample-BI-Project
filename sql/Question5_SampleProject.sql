--Payhawk Associate BI Analyst Interview Project
--Author: Viktor Dimitrov
--Date: 07 of April 2026
-- Description: Financial analysis of company spending patterns
-- ================================================
-- Question 5: Top Employee by Number of Expense Reports
-- ================================================

SELECT
e.name, COUNT(ex.report_id) AS total_reports, ROUND(AVG(ex.amount),2) AS avg_amount
FROM expense_reports ex
JOIN employees e ON ex.employee_id=e.employee_id
GROUP BY e.name
ORDER BY total_reports DESC
Limit 5;