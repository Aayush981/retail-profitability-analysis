# Retail Profitability & Discount Impact Analysis
### SQL | Power BI | Excel

---

## The Problem I Was Trying to Solve

Most people look at $2.3M in revenue and think the business is doing well.

I wanted to find out why, despite that revenue, the profit margin was sitting at just 12.5%.
Something was quietly eating into the numbers — and I wanted to find exactly what.

---

## What I Used

- **MySQL** — querying 10,000+ transactions, calculating KPIs, analyzing discount tiers
- **Power BI** — building an interactive dashboard with drill-through filters
- **Excel** — initial data cleaning and validation

Dataset: Sample Superstore Dataset (Kaggle) — 9,994 retail transactions across 
categories, regions, and customer segments.

---

## What I Found

**1. High revenue was masking a profitability problem**
$2.3M in revenue sounds strong. But after discounts and costs, only $286K 
in profit remained — a 12.5% margin that signals something is structurally off.

**2. Furniture looked strong on the surface — but wasn't**
Furniture was generating solid sales volume. What it wasn't generating was profit. 
High revenue with weak margins is one of the easiest things to miss if you're 
only watching the top line.

**3. Tables and Bookcases were quietly losing money**
These two sub-categories were consistently generating negative profit across 
multiple regions — not occasionally, consistently. The business was essentially 
paying to sell these products.

**4. Discounts above 20–30% were the main culprit**
Once discounts crossed that threshold, margins collapsed. The business was 
chasing sales volume at the direct expense of profitability — a classic 
growth-vs-margin trap.

**5. Peak season sales didn't fix the problem**
Revenue spiked toward year-end. Profit didn't follow proportionally. 
More sales were just hiding the same underlying inefficiency.

---

## What I Recommended

- Set discount caps by sub-category — not a blanket discount policy
- Stop promoting Tables and Bookcases until pricing or supplier costs are reviewed
- Shift focus toward high-margin sub-categories: Copiers, Phones, Accessories
- Track profit alongside revenue on every report — not as an afterthought

---

## The Dashboard

Built in Power BI with drill-through filters so you can move from 
overall performance → category → sub-category → region in a few clicks.

![Dashboard Overview](Images/dashboard_overview.png)

---

## What This Project Taught Me

Revenue is vanity, profit is sanity — but you need the data to prove it.

This project changed how I think about business metrics. Strong top-line 
numbers can hide serious operational problems. The job of analysis isn't 
just to report what happened — it's to find what the surface numbers 
aren't telling you.

---

## Files in This Repository

| File | Description |
|------|-------------|
| [analysis_queries.sql](SQL/analysis_queries.sql) | All SQL queries used in the analysis |
| [database_setup.sql](SQL/database_setup.sql) | Database and table setup queries |
| [ecommerce_sales_dashboard.pbix](Dashboard/ecommerce_sales_dashboard.pbix) | Power BI dashboard file |
| [Sample - Superstore.csv](Data/Raw/Sample%20-%20Superstore.csv) | Raw dataset used |
| [Images/](Images/) | Dashboard screenshots |
