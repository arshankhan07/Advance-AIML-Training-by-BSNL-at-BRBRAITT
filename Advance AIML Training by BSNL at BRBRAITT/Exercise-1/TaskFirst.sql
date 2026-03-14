

use bsnl_training;
create table usage_data(
customer_id INT,
data_used_in_GB FLOAT,
calls_made INT,
revenue_inr FLOAT,
region  varchar(20)
);

INSERT INTO usage_data VALUES
(1001, 5.2, 25, 180, 'Delhi'),
(1002, 12.5, 40, 280, 'Mumbai'),
(1003, 7.8, 32, 210, 'Chennai'),
(1004, 15.6, 55, 320, 'Delhi'),
(1005, 3.4, 18, 120, 'Kolkata');


select * from usage_data;


CREATE TABLE customers (
customer_id INT,

name VARCHAR(50),
plan_type VARCHAR(20),
join_date DATE
);



INSERT INTO customers VALUES
(1001, 'Asha Mehta', 'Prepaid', '20230512'),
(1002, 'Ravi Kumar', 'Postpaid', '20221220'),
(1003, 'Sneha Rao', 'Prepaid', '20230118'),
(1004, 'Manoj Singh', 'Postpaid', '20211105'),
(1005, 'Divya Jain', 'Prepaid', '20230328');

select * from customers;

-- Goal: Filter customers exceeding 10 GB usage.
SELECT customer_id, data_used_in_GB
FROM usage_data
WHERE data_used_in_GB>10
ORDER BY data_used_in_GB DESC;

-- Goal: Combine customer information with usage details
SELECT c.name, c.plan_type, u.data_used_in_GB, u.region
FROM customers c
JOIN usage_data u ON c.customer_id = u.customer_id;


-- Goal: Find average data usage per region.-- 

SELECT region, AVG(data_used_in_GB) AS avg_usage
FROM usage_data
GROUP BY region;

SELECT region, ROUND(AVG(data_used_in_GB),2) AS avg_usage
FROM usage_data
GROUP BY region;




-- Business requirement: Identify which are the highest generating revenue plans and regions -&gt;
-- which we can target for premium upsells.
SELECT c.plan_type, u.region, AVG(u.revenue_inr) AS avg_revenue
FROM customers c
JOIN usage_data u ON c.customer_id = u.customer_id
GROUP BY u.region, c.plan_type
ORDER BY avg_revenue DESC;