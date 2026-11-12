SET search_path=isaacmart;
BEGIN;
UPDATE products SET stock=stock-2 WHERE product_id=1 AND stock>=2 RETURNING product_id,stock;
COMMIT;
SELECT stock AS after_commit FROM products WHERE product_id=1;
BEGIN;
UPDATE products SET stock=stock-5 WHERE product_id=1 RETURNING stock;
ROLLBACK;
SELECT stock AS after_rollback FROM products WHERE product_id=1;
