# 💳 Payhawk BI Sample Project
> Financial spend analysis using SQL and Tableau, built on simulated fintech data.

![SQL](https://img.shields.io/badge/SQL-SQLite-blue) ![Tableau](https://img.shields.io/badge/Tableau-Public-orange) ![Status](https://img.shields.io/badge/Status-Complete-green)

---

## 📌 Project Overview

This project simulates a real-world BI analyst workflow at a fintech company similar to **Payhawk** — a corporate spend management platform. The goal is to answer key business questions around company spending, budget compliance, employee expense behaviour, and transaction failures using **SQL** for data preparation and **Tableau** for visual analytics.

All data is **synthetically generated** and does not represent any real individuals or companies.

---

## 🗂️ Data Model

The project uses 7 CSV files simulating a fintech database:

| Table | Description |
|---|---|
| `transactions` | Corporate card transactions (approved & declined) |
| `cards` | Corporate cards assigned to employees |
| `companies` | Client companies using the platform |
| `employees` | Employees within each company |
| `budgets` | Department-level budget allocations |
| `expense_reports` | Employee-submitted expense reports |
| `date_dim` | Date dimension table for time-based analysis |

---

## ❓ Business Questions Answered

| # | Question | SQL Query | Tableau Sheet |
|---|---|---|---|
| Qn1 | Which companies spend the most? | `Q1_top_spending_companies.sql` | Top Spending Companies |
| Qn2 | How does spending change month over month? | `Q2_month_over_month.sql` | Month-over-Month Spending |
| Qn3 | Which companies and departments exceed their budget? | `Q3_budget_status.sql` | Budget Status Heatmap |
| Qn4 | Which employees have declined transactions and where? | `Q4_declined_transactions.sql` | Declined Transactions Heatmap |
| Qn5 | Which employee submits the most expense reports? | `Q5_top_employee.sql` | Top Employee Lollipop Chart |
| Qn6 | Which employees have above-average expense amounts? | `Q6_above_average.sql` | Above Average Bubble Chart |

---

## 🔍 SQL Highlights

### Qn2 — Month-over-Month Spending (Window Function)
```sql
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
```

### Qn6 — Above Average Expense Amount (Subquery)
```sql
SELECT
    e.name,
    c.company_name,
    ROUND(AVG(ex.amount), 2) AS avg_amount
FROM expense_reports ex
JOIN employees e ON ex.employee_id = e.employee_id
JOIN companies c ON ex.company_id = c.company_id
GROUP BY e.name, c.company_name
HAVING ROUND(AVG(ex.amount), 2) > (
    SELECT AVG(amount) FROM expense_reports
);
```

---

## 📊 Tableau Dashboards

### Dashboard 1: Company Financial Overview
Answers the question: *"How are our client companies performing financially?"*

**Sheets included:**
- 📊 **Qn1 — Top Spending Companies** (Horizontal Bar Chart)
- 📈 **Qn2 — Month-over-Month Spending** (Multi-line Chart with MoM Tooltip)
- 🟥 **Qn3 — Budget Status by Company & Department** (Heatmap)

**KPI Cards:**
| KPI | Value | Color |
|---|---|---|
| On Budget | 1 | 🟢 Green |
| Near Limit | 6 | 🟠 Orange |
| Over Budget | 2 | 🔴 Red |
| Total Departments | 9 | 🔵 Blue |

---

### Dashboard 2: Employee & Transaction Analysis
Answers the question: *"Which employees pose a financial risk or stand out in spend behaviour?"*

**Sheets included:**
- 🟦 **Qn4 — Declined Transactions** (Heatmap by Company & Employee)
- 🎯 **Qn5 — Top Employee by Expense Reports** (Lollipop Chart)
- 💰 **Qn6 — Above Average Expense Amount** (Bubble Chart)

**KPI Cards:**
| KPI | Value | Color |
|---|---|---|
| Declined Transactions | 12 | 🔴 Red |
| Above-Average Employees | 6 | 🔵 Blue |

**Interactivity:**
- 🔵 **Filter Action** — Click a bubble in Q6 → filters Q4 and Q5 for that employee
- 🟡 **Highlight Action** — Hover over employee in Q5 → highlights them in Q4

---

## 🛠️ Tools Used

| Tool | Purpose |
|---|---|
| **SQLite / DB Browser** | Data querying and transformation |
| **Tableau Public** | Data visualisation and dashboards |
| **VS Code** | SQL file editing |
| **GitHub** | Version control and portfolio hosting |

---

## 📁 Repository Structure

```
Sample-BI-Project/
│
├── raw data/               # Source CSV files (7 tables)
│   ├── transactions.csv
│   ├── cards.csv
│   ├── companies.csv
│   ├── employees.csv
│   ├── budgets.csv
│   ├── expense_reports.csv
│   └── date_dim.csv
│
├── sql/                    # SQL queries (one per business question)
│   ├── Question1_top_spending_companies.sql
│   ├── Question2_month_over_month.sql
│   ├── Question3_budget_status.sql
│   ├── Question4_declined_transactions.sql
│   ├── Question5_top_employee.sql
│   └── Question6_above_average.sql
│
└── README.md
```

---

## 🔗 Live Dashboard

📌 View the interactive Tableau dashboards on **Tableau Public**:
> [Dashboard 1: Company Financial Overview](https://public.tableau.com/app/profile/viktor.dimitrov/viz/BI-SampleProject/PayhawkBISampleProject-CompanyFinancialOverview)

> [Dashboard 2: Employee & Transaction Analysis](https://public.tableau.com/app/profile/viktor.dimitrov/viz/BI-SampleProject/PayhawkBISampleProject-EmployeeTransactionAnalysis)


---

## 👤 Author

**Viktor Dimitrov**  
Data & BI Analyst | SQL • Tableau • Power BI
Transitioning from GfK Power BI experience to fintech BI
[GitHub](https://github.com/viktordimitrov89)
