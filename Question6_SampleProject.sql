--Payhawk Associate BI Analyst Interview Project
--Author: Viktor Dimitrov
--Date: 07 of April 2026
-- Description: Financial analysis of company spending patterns
-- ================================================
-- Question 6: Employees with Above Average Expense Report Amount
-- ================================================

SELECT
e.name, c.company_name, ROUND(AVG(ex.amount),2) AS avg_amount
FROM expense_reports ex
JOIN employees e ON ex.employee_id=e.employee_id
JOIN companies c ON ex.company_id=c.company_id
GROUP BY e.name, c.company_name
HAVING ROUND(AVG(ex.amount),2) > (SELECT AVG(amount) from expense_reports);