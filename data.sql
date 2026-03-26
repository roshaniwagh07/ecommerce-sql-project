INSERT INTO customers (name, email, city) VALUES
('Rohit Sharma', 'rohit@gmail.com', 'Mumbai'),
('Anita Desai', 'anita@gmail.com', 'Pune'),
('Rahul Verma', 'rahul@gmail.com', 'Delhi'),
('Sneha Patil', 'sneha@gmail.com', 'Pune'),
('Amit Shah', 'amit@gmail.com', 'Ahmedabad');

INSERT INTO categories (category_name) VALUES
('Electronics'),
('Clothing'),
('Home Appliances');

INSERT INTO products (product_name, price, category_id) VALUES
('Laptop', 60000, 1),
('Mobile', 20000, 1),
('T-Shirt', 500, 2),
('Jeans', 1500, 2),
('Microwave', 8000, 3);

INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2024-01-10', 'Delivered'),
(2, '2024-01-12', 'Pending'),
(1, '2024-02-05', 'Delivered'),
(3, '2024-02-10', 'Cancelled'),
(4, '2024-03-01', 'Delivered');

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 60000),
(1, 3, 2, 500),
(2, 2, 1, 20000),
(3, 2, 1, 20000),
(3, 4, 1, 1500),
(4, 5, 1, 8000),
(5, 3, 3, 500);


ALTER TABLE payments
CHANGE pyment_date payment_date DATE;

INSERT INTO payments (order_id, payment_date, amount, payment_method) VALUES
(1, '2024-01-10', 61000, 'UPI'),
(2, '2024-01-12', 20000, 'Credit Card'),
(3, '2024-02-05', 21500, 'Debit Card'),
(5, '2024-03-01', 1500, 'UPI');
