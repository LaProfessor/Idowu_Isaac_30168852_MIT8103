BEGIN ISOLATION LEVEL REPEATABLE READ;
SELECT stock FROM isaacmart.products WHERE product_id=2;
-- In another session run: UPDATE isaacmart.products SET stock=stock+1 WHERE product_id=2;
SELECT stock FROM isaacmart.products WHERE product_id=2;
COMMIT;
-- READ COMMITTED uses a new snapshot for each statement; REPEATABLE READ retains its snapshot.
