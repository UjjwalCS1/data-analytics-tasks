# Online Sales Data Analysis Using SQL

## Overview

This project contains SQL queries for analyzing an online sales dataset stored in the `online_sales_data` table. The queries cover revenue analysis, product performance, regional sales insights, payment method analysis, monthly trends, and advanced SQL window functions such as `RANK()`, `DENSE_RANK()`, `LAG()`, and `LEAD()`.

---

## Dataset Columns

The analysis uses the following columns:

* Date
* Product Name
* Product Category
* Units Sold
* Unit Price
* Total Revenue
* Region
* Payment Method

---

## SQL Analysis Included

### Basic Analysis

1. Total Revenue
2. Total Units Sold
3. Average Unit Price

### Revenue Analysis

4. Revenue by Product Category
5. Revenue by Region
6. Revenue by Payment Method
7. Monthly Revenue

### Product Performance

8. Top 5 Products by Revenue
9. Highest Revenue Transaction

### Ranking Functions

10. Rank Products by Revenue (Top 15)
11. Rank Regions by Revenue

### Window Functions

12. Previous Month Revenue using `LAG()`
13. Next Month Revenue using `LEAD()`
14. Month-over-Month Revenue Growth

### Advanced Analysis

15. Top Product in Each Category using `RANK()`

---

## SQL Concepts Used

* Aggregate Functions

  * SUM()
  * AVG()

* Grouping

  * GROUP BY

* Sorting

  * ORDER BY

* Filtering Results

  * LIMIT

* Window Functions

  * RANK()
  * DENSE_RANK()
  * LAG()
  * LEAD()

* Partitioning

  * PARTITION BY

---

## Database Compatibility

Designed for **MySQL 8.0+** because it uses Window Functions.

---

## Learning Outcomes

By studying these queries, you will learn:

* Sales data analysis with SQL
* Revenue reporting
* Product performance evaluation
* Trend analysis
* Ranking techniques
* Window function implementation
* Business intelligence reporting

---

## File Structure

```text
Project/
│
├── online_sales_data.csv
├── onlinesales.sql
└── README.md
```

---

## Author

SQL Practice Project for Data Analysis and Business Intelligence using MySQL.
