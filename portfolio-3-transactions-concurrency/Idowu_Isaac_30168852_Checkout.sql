SET search_path = isaacmart;
BEGIN;

DO $$
BEGIN
    -- Reserve one unit only if sufficient stock remains.
    UPDATE products
    SET stock = stock - 1
    WHERE product_id = 1 AND stock >= 1;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Checkout aborted: product unavailable or out of stock';
    END IF;

    INSERT INTO orders
        (order_id, customer_id, ordered_at, status)
    VALUES
        (200001, 1, now(), 'pending');

    -- Preserve the price charged for this order.
    INSERT INTO order_items
        (order_id, product_id, quantity, unit_price)
    SELECT 200001, product_id, 1, price
    FROM products
    WHERE product_id = 1;

    -- Derive the pending payment amount from the order lines.
    INSERT INTO payments
        (payment_id, order_id, reference, amount, status)
    SELECT
        200001,
        200001,
        'DEMO-200001',
        SUM(quantity * unit_price),
        'pending'
    FROM order_items
    WHERE order_id = 200001;
END $$;

SELECT
    oi.order_id,
    oi.product_id,
    oi.quantity,
    oi.unit_price,
    p.amount AS pending_payment_ngn
FROM order_items oi
JOIN payments p USING (order_id)
WHERE oi.order_id = 200001;

-- External payment processing requires a separate,
-- idempotent workflow, such as an outbox-based process.
ROLLBACK;

SELECT stock AS stock_after_rollback
FROM products
WHERE product_id = 1;

SELECT COUNT(*) AS demo_orders_after_rollback
FROM orders
WHERE order_id = 200001;
