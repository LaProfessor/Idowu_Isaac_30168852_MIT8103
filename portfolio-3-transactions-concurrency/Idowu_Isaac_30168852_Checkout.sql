-- Standalone demonstration; ROLLBACK keeps the seeded ledger unchanged.
SET search_path=isaacmart;
BEGIN;
-- Require exactly one returned row; otherwise abort checkout (out of stock).
UPDATE products SET stock=stock-1 WHERE product_id=1 AND stock>=1 RETURNING stock;
INSERT INTO orders VALUES(200001,1,now(),'pending');
INSERT INTO order_items SELECT 200001,product_id,1,price FROM products WHERE product_id=1;
INSERT INTO payments VALUES(200001,200001,'DEMO-200001',1000,'pending');
-- An external payment gateway cannot participate in this local transaction.
-- In production, publish an outbox event and process payment idempotently.
SELECT order_id,product_id,quantity,unit_price FROM order_items WHERE order_id=200001;
ROLLBACK;
