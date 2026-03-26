-- Total number of orders per customer
SELECT C.CUSTOMER_ID,C.NAME,COUNT(*) AS TOTAL_ORDERS FROM ORDERS O
JOIN CUSTOMERS C 
ON C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID,C.NAME;

-- Total revenue (sum of payments)
SELECT SUM(AMOUNT) FROM PAYMENTS ;

-- Find customers who never placed an order
SELECT C.CUSTOMER_ID,C.NAME FROM CUSTOMERS C
LEFT JOIN ORDERS O
ON O.CUSTOMER_ID = C.CUSTOMER_ID
WHERE O.ORDER_ID IS NULL;

-- Top 3 selling products (by quantity)
SELECT product_name, total_quantity
FROM (
    SELECT P.product_name,
           SUM(O.quantity) AS total_quantity,
           DENSE_RANK() OVER (ORDER BY SUM(O.quantity) DESC) AS rnk
    FROM order_items O
    JOIN products P ON P.product_id = O.product_id
    GROUP BY P.product_id, P.product_name
) t
WHERE rnk <= 3;

-- Monthly revenue
SELECT YEAR(PAYMENT_DATE) AS YEAR,MONTHNAME(PAYMENT_DATE) AS MONTH,SUM(AMOUNT) AS TOTAL_REVENUE 
FROM payments
GROUP BY YEAR(PAYMENT_DATE),MONTHNAME(PAYMENT_DATE);

-- Find top 2 customers who spent the most money

SELECT *
FROM (
    SELECT 
        o.customer_id,
        c.name,
        SUM(oi.price * oi.quantity) AS total_spend,
        DENSE_RANK() OVER(ORDER BY SUM(oi.price * oi.quantity) DESC) AS rnk
    FROM customers c 
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.customer_id, c.name
) t
WHERE rnk = 2;

-- Find top customer in each month
SELECT * FROM (
	SELECT O.CUSTOMER_ID,
    C.NAME,
    YEAR(O.order_date) AS YEAR,
    month(O.ORDER_DATE) AS MONTH,
    SUM(OI.PRICE * OI.QUANTITY) AS TOTAL_SPEND,
	dense_rank() OVER(
						PARTITION BY YEAR(O.order_date),month(O.ORDER_DATE) ORDER BY SUM(OI.PRICE * OI.QUANTITY) DESC
					 ) AS rnk
	FROM customers C 
	JOIN orders O ON C.customer_id = O.customer_id
	JOIN order_items OI ON O.order_id = OI.order_id
	group by O.CUSTOMER_ID,C.NAME,YEAR(O.order_date),month(O.ORDER_DATE)
    ) AS T
WHERE rnk = 1;

-- Segment customers into:
-- High spenders (> 30000)
-- Medium (10000–30000)
-- Low (< 10000)

SELECT O.CUSTOMER_ID,
C.NAME,
SUM(OI.PRICE * OI.QUANTITY) AS TOTAL_SPEND,
CASE 
	WHEN SUM(OI.PRICE * OI.QUANTITY) > 30000 THEN 'HIGH SPENDERS'
    WHEN SUM(OI.PRICE * OI.QUANTITY) between 10000 AND 30000 THEN 'MEDIUM SENDERS'
    ELSE 'LOW SPENDERS'
END
AS SEGMENT
FROM customers C 
	JOIN orders O ON C.customer_id = O.customer_id
	JOIN order_items OI ON O.order_id = OI.order_id
	group by O.CUSTOMER_ID,C.NAME;
