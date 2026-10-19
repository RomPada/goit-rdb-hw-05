
USE hw_2;

-- Task 1
SELECT
    od.*,
    (
        SELECT o.customer_id
        FROM orders AS o
        WHERE o.id = od.order_id
    ) AS customer_id
FROM order_details AS od;

-- Task 2
SELECT *
FROM order_details
WHERE order_id IN (
    SELECT id
    FROM orders
    WHERE shipper_id = 3
);

-- Task 3
SELECT
    temp.order_id,
    AVG(temp.quantity) AS avg_quantity
FROM (
    SELECT order_id, quantity
    FROM order_details
    WHERE quantity > 10
) AS temp
GROUP BY temp.order_id;

-- Task 4
WITH temp AS (
    SELECT order_id, quantity
    FROM order_details
    WHERE quantity > 10
)
SELECT
    order_id,
    AVG(quantity) AS avg_quantity
FROM temp
GROUP BY order_id;

-- Task 5
DROP FUNCTION IF EXISTS divide_float;

CREATE FUNCTION divide_float(a FLOAT, b FLOAT)
RETURNS FLOAT
DETERMINISTIC
NO SQL
RETURN a / NULLIF(b, 0);

SELECT
    od.*,
    divide_float(od.quantity, 2.0) AS divided_quantity
FROM order_details AS od;
