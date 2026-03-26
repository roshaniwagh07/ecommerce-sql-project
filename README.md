# 🛒 E-commerce Sales Analysis (SQL Project)

## 📌 Overview

This project analyzes an e-commerce dataset using SQL to extract business insights such as customer behavior, product performance, and revenue trends.

## 🧱 Database Design

The database consists of the following tables:

* customers
* orders
* order_items
* products
* categories
* payments

## 📊 Key Analysis Performed

* Top customers by spending
* Monthly revenue trends
* Best-selling products
* Customer segmentation (High, Medium, Low spenders)
* Repeat customers
* Customers with no orders

## 🧠 Key Insights

* High spenders contribute significantly to revenue
* Certain products dominate sales volume
* Repeat customers generate higher value
* Sales trends vary across months

## 🛠️ Tools Used

* MySQL
## 📸 Sample Queries

### 🔹 Top Customers

```sql
SELECT c.customer_id, c.name, SUM(oi.price * oi.quantity) AS total_spend
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.name
ORDER BY total_spend DESC;
```

### 🔹 Monthly Revenue

```sql
SELECT YEAR(payment_date), MONTH(payment_date), SUM(amount)
FROM payments
GROUP BY YEAR(payment_date), MONTH(payment_date);
```

---

## 🌟 Future Improvements

* Add Power BI dashboard
* Add more real-world datasets
* Optimize queries using indexing
