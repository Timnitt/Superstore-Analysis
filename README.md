# Superstore Sales Analysis

**End-to-end retail analytics project** using SQL for data analysis and Power BI for interactive dashboards- built to answer real business questions about profitability, discounting, and regional performance.

---

## Project overview

The Superstore dataset contains ~10,000 retail transactions across the United States from 2019–2022. This project simulates a real analyst workflow: cleaning raw data, writing structured SQL queries, and presenting findings through a three-page Power BI dashboard.

**Business problem:** Management lacks visibility into which products, regions, and discount levels are driving or destroying profit.

**Goal:** Identify profit drivers, flag loss-making segments, and recommend data-driven pricing and discount strategies.

---

## Key findings

| Metric | Result |
|---|---|
| Total revenue | $2.30M |
| Total profit | $286K |
| Overall profit margin | 12.47% |
| Best-performing region | West (31.6% of total sales) |
| Largest customer segment | Consumer (51% of sales) |
| Top category by revenue | Technology |

**Critical insight:** Discounts above 20% consistently produce negative profit margins across multiple sub-categories. Tables and Bookcases operate at a structural loss regardless of discount level.

---

## Dashboard previews

> Export your three dashboard screenshots from Power BI and place them in `/screenshots`. Then replace the placeholder paths below.

**Page 1 — Sales overview**

https://github.com/Timnitt/Superstore-Analysis/blob/main/screenshots/Overview.PNG

Tracks total revenue, profit, and order volume over time. Highlights monthly seasonality and year-over-year growth.

**Page 2 — Regional and category performance**

https://github.com/Timnitt/Superstore-Analysis/blob/main/screenshots/Regional.PNG

Breaks down sales and profit by region, state, category, and sub-category. Identifies top performers and loss-making products.

**Page 3 — Profitability and discount impact**

https://github.com/Timnitt/Superstore-Analysis/blob/main/screenshots/Profitablity%20and%20discounts.PNG

Analyses the relationship between discount levels, sales volume, and profit margin. Reveals the discount thresholds where profit turns negative.

---

## Repository structure

```
superstore-analysis/
│
├── README.md                    ← You are here
├── .gitignore
│
├── data/
│   ├── Sample_Superstore.csv    ← Raw source data (9,994 rows, 21 columns)
│   └── Superstore_clean.csv     ← Cleaned analytical dataset (9,986 rows, 13 columns)
│
├── sql/
│   ├── superstore_analysis.sql  ← Exploratory queries: KPIs, trends, discount impact
│   └── superstore_views.sql     ← Production views used as Power BI data source
│
├── dashboard/
│   └── Sales_dashboard.pbix     ← Power BI file (open in Power BI Desktop)
│
├── screenshots/
│   ├── dashboard_sales_overview.png
│   ├── dashboard_regional_performance.png
│   └── dashboard_discount_impact.png
│
└── docs/
    └── data_dictionary.md       ← Column definitions and cleaning decisions
```

---

## Tools and technologies

| Tool | Purpose |
|---|---|
| Microsoft Excel / Power Query | Data cleaning and validation |
| MSSQL | Data analysis, KPI queries, SQL views |
| Power BI Desktop | Data modelling, DAX measures, dashboard |

---

## SQL highlights

Four core queries power the analysis. All are saved as reusable views for the Power BI connection.

**Overall KPIs**
```sql
SELECT
    COUNT(DISTINCT order_id)           AS total_orders,
    ROUND(SUM(sales), 2)               AS total_sales,
    ROUND(SUM(profit), 2)              AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM superstore_db;
```

**Monthly sales trend with category breakdown**
```sql
SELECT
    YEAR(order_date)          AS year,
    MONTH(order_date)         AS month,
    category,
    COUNT(DISTINCT order_id)  AS orders,
    SUM(sales)                AS total_sales,
    SUM(profit)               AS total_profit
FROM superstore_db
GROUP BY YEAR(order_date), MONTH(order_date), category
ORDER BY year, month;
```

**Discount impact on profitability**
```sql
SELECT
    region,
    category,
    sub_category,
    discount,
    ROUND(SUM(profit), 2)    AS total_profit,
    SUM(sales)               AS total_sales,
    COUNT(DISTINCT order_id) AS total_orders
FROM superstore_db
GROUP BY region, category, sub_category, discount
ORDER BY discount;
```

Full queries and views: [`SQL_analysis/superstoreanalysis.sql`](SQL_analysis/superstoreanalysis.sql) and [`SQL_analysis/superstore_view.sql`](SQL_analysis/superstore_view.sql)

---

## Data cleaning summary

The raw dataset (9,994 rows) was cleaned in Excel Power Query before SQL analysis.

| Step | Action |
|---|---|
| Duplicates | Removed 8 duplicate rows (matched on Order ID + Product ID + Order Date) |
| Missing values | Removed rows with blank Sales, Quantity, or Order Date fields |
| Data types | Standardised date formats; converted Sales, Profit, Discount to numeric |
| Text formatting | Applied TRIM and PROPER to category, region, and product name columns |
| Business rules | Validated Sales ≥ 0 and Quantity > 0; flagged and removed violations |
| Column reduction | Dropped non-analytical columns (Row ID, Postal Code, Ship Date, Ship Mode) |

Full column reference: [`docs/data_dictionary.md`](docs/data_dictionary.md)

---

## Key recommendations

1. **Restructure discount strategy** — Cap discounts at 20% across all categories. Discounts above this threshold produce negative margins in Furniture and Office Supplies.
2. **Discontinue or reprice loss-making sub-categories** — Tables and Bookcases are consistently unprofitable. Review supplier costs or exit these lines.
3. **Invest in the West region** — Consistently the highest revenue and profit region. Targeted promotions here yield the best ROI.
4. **Scale Technology category** — Highest revenue category with strong margins, especially Copiers and Phones. Prioritise inventory and marketing here.
5. **Monitor monthly seasonality** — Sales peak in November–December. Align inventory and staffing to seasonal demand curves.

---

## How to run this project

**SQL queries**
1. Import `data/Superstore_clean.csv` into MySQL as a table named `superstore_db`
2. Run `sql/superstore_views.sql` to create the four analytical views
3. Run `sql/superstore_analysis.sql` to reproduce the exploratory analysis

**Power BI dashboard**
1. Open `dashboard/Sales_dashboard.pbix` in Power BI Desktop
2. Update the data source connection to point to your MSSQL instance (or load the CSV directly)
3. Refresh the data model

---

## About this project

Built as a portfolio project to demonstrate an end-to-end data analytics workflow - from raw data to business recommendations- using industry-standard tools.

**Contact:** Timnit Gebregergis · https://www.linkedin.com/in/timnitgebregergis/ · timnitgebregergis@gmail.com
