--Payhawk Associate BI Analyst Interview Project
--Author: Viktor Dimitrov
--Date: 07 of April 2026
-- Description: Financial analysis of company spending patterns
-- ================================================
-- Question 2: Question 2: Month-over-Month Spending by Company
-- ================================================

SELECT
    company_name,
    month,
    month_name,
    total_amount,
    prev_amount,
    ROUND(total_amount - prev_amount, 2) AS change_vs_prev,
    ROUND((total_amount - prev_amount) / prev_amount * 100, 1) AS pct_change
FROM (
    SELECT
        c.company_name,
        d.month,
        d.month_name,
        ROUND(SUM(t.amount), 2) AS total_amount,
        LAG(ROUND(SUM(t.amount), 2)) OVER (
            PARTITION BY c.company_name ORDER BY d.month
        ) AS prev_amount
    FROM transactions t
    JOIN companies c ON t.company_id = c.company_id
    JOIN date_dim d ON t.date = d.date
    GROUP BY c.company_name, d.month, d.month_name
)
WHERE prev_amount IS NOT NULL;