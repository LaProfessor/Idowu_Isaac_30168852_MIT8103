DROP SCHEMA IF EXISTS isaacmart CASCADE;
CREATE SCHEMA isaacmart;
SET search_path=isaacmart;
CREATE TABLE customers(customer_id integer PRIMARY KEY, full_name text NOT NULL, email text NOT NULL UNIQUE);
CREATE TABLE categories(category_id integer PRIMARY KEY, name text NOT NULL UNIQUE);
CREATE TABLE products(product_id integer PRIMARY KEY, category_id integer NOT NULL REFERENCES categories, sku text NOT NULL UNIQUE, name text NOT NULL, price numeric(12,2) NOT NULL CHECK(price>=0), stock integer NOT NULL CHECK(stock>=0));
CREATE TABLE orders(order_id integer PRIMARY KEY, customer_id integer NOT NULL REFERENCES customers, ordered_at timestamptz NOT NULL, status text NOT NULL CHECK(status IN ('pending','paid','shipped','cancelled')));
CREATE TABLE order_items(order_id integer REFERENCES orders, product_id integer REFERENCES products, quantity integer NOT NULL CHECK(quantity>0), unit_price numeric(12,2) NOT NULL CHECK(unit_price>=0), PRIMARY KEY(order_id,product_id));
CREATE TABLE payments(payment_id integer PRIMARY KEY, order_id integer NOT NULL REFERENCES orders, reference text NOT NULL UNIQUE, amount numeric(12,2) NOT NULL CHECK(amount>0), status text NOT NULL CHECK(status IN ('pending','succeeded','failed')));
