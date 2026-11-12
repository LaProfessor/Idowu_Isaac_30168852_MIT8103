SET search_path=isaacmart;
-- Customer history; compare plans before and after creating the index.
SELECT order_id,ordered_at,status FROM isaacmart.orders WHERE customer_id=38 ORDER BY ordered_at DESC LIMIT 10;
-- Paid order value by category (one item per synthetic order).
SELECT c.name,sum(oi.quantity*oi.unit_price) AS value_ngn FROM categories c JOIN products p USING(category_id) JOIN order_items oi USING(product_id) JOIN orders o USING(order_id) WHERE o.status='paid' GROUP BY c.name ORDER BY value_ngn DESC;
-- Customers with no orders.
SELECT count(*) AS customers_without_orders FROM customers c WHERE NOT EXISTS(SELECT 1 FROM orders o WHERE o.customer_id=c.customer_id);
-- Monthly paid sales, using the business timezone explicitly.
SELECT date_trunc('month',o.ordered_at AT TIME ZONE 'Africa/Lagos') AS month,sum(oi.quantity*oi.unit_price) AS sales_ngn FROM orders o JOIN order_items oi USING(order_id) WHERE o.status='paid' GROUP BY 1 ORDER BY 1;
-- Payment reconciliation, expected zero discrepancies in the generated data.
SELECT count(*) AS mismatches FROM (SELECT o.order_id,sum(oi.quantity*oi.unit_price) AS due FROM orders o JOIN order_items oi USING(order_id) WHERE o.status='paid' GROUP BY o.order_id) totals LEFT JOIN (SELECT order_id,sum(amount) AS received FROM payments WHERE status='succeeded' GROUP BY order_id) paid USING(order_id) WHERE totals.due<>coalesce(paid.received,0);
