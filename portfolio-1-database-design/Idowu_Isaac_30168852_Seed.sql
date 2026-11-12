SET search_path=isaacmart;
INSERT INTO customers SELECT i,'Customer '||i,'customer'||i||'@example.invalid' FROM generate_series(1,10000) i;
INSERT INTO categories VALUES(1,'Electronics'),(2,'Home'),(3,'Fashion');
INSERT INTO products SELECT i,1+(i%3),'SKU-'||i,'Product '||i,1000+(i%100)*50,100 FROM generate_series(1,1000)i;
INSERT INTO orders SELECT i,1+((i*37)%10000),timestamptz '2026-01-01 00:00:00+01'+(i||' minutes')::interval,CASE WHEN i%10=0 THEN 'pending' ELSE 'paid' END FROM generate_series(1,200000)i;
INSERT INTO order_items SELECT order_id,1+(order_id%1000),1+(order_id%3),p.price FROM orders JOIN products p ON p.product_id=1+(order_id%1000);
INSERT INTO payments SELECT o.order_id,o.order_id,'PAY-'||o.order_id,oi.quantity*oi.unit_price,'succeeded' FROM orders o JOIN order_items oi USING(order_id) WHERE o.status='paid';
ANALYZE;
