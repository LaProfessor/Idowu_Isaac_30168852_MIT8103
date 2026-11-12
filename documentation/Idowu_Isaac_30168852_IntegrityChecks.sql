DO $$
BEGIN
 ASSERT (SELECT count(*) FROM isaacmart.orders)=200000, 'order count';
 ASSERT (SELECT stock FROM isaacmart.products WHERE product_id=1)=98, 'commit rollback state';
 BEGIN UPDATE isaacmart.products SET stock=-1 WHERE product_id=1; RAISE EXCEPTION 'negative stock accepted'; EXCEPTION WHEN check_violation THEN RAISE NOTICE 'PASS negative stock rejected'; END;
 BEGIN INSERT INTO isaacmart.orders VALUES(999999,999999,now(),'pending'); RAISE EXCEPTION 'missing customer accepted'; EXCEPTION WHEN foreign_key_violation THEN RAISE NOTICE 'PASS missing customer rejected'; END;
 BEGIN INSERT INTO isaacmart.customers VALUES(10001,'Duplicate','customer1@example.invalid'); RAISE EXCEPTION 'duplicate email accepted'; EXCEPTION WHEN unique_violation THEN RAISE NOTICE 'PASS duplicate email rejected'; END;
 RAISE NOTICE 'PASS counts and transaction final state';
END $$;
