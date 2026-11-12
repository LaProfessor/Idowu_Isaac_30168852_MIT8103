IsaacMart is a simulated Nigerian online retailer. Customers place orders; warehouse staff maintain products and stock; finance staff reconcile payments; managers inspect sales. Data includes customers, categories, products, orders, line items and payment attempts. All identities and transactions are synthetic, with money in NGN.

Business rules and scope
Each product belongs to exactly one category. An order belongs to one customer and can have multiple distinct product lines; line quantities represent repeated units. A payment attempt belongs to one order; multiple attempts are allowed, with unique provider references preventing duplicate recording. Real payments require provider verification. The sample excludes refunds, taxes, shipping addresses, delivery and customer authentication. Paid status must be changed by a verified application workflow, not arbitrary clients.

Normalisation to 3NF
An unnormalised order with repeating product fields is split into Orders and OrderItems. Each atomic line has composite key (order_id,product_id). Quantity and historical unit_price depend on the whole key. Customer email/name move to Customers; product SKU/name/current price move to Products; category name moves to Categories. This removes partial and transitive dependencies. Under the stated dependencies, non-key attributes depend on their table key, and each table is in 3NF. Historical unit_price is a sale-time fact, not a copy to synchronise with current product price. Order totals are calculated rather than stored.

SQL constraints enforce references, unique emails/SKUs/references, allowed statuses and nonnegative prices/stock. They do not enforce order existence of at least one line or equality of successful payment totals to order value. An application transaction and reconciliation query handle those cross-row rules. These are documented limitations, not guarantees provided by CHECK constraints.

Evidence: Schema.sql, Seed.sql, SetupEvidence.txt and ERDiagram.pdf. Run schema before seed; schema reset deletes only the isaacmart demonstration schema. Seed creates 10,000 customers, 1,000 products, 200,000 orders, 200,000 lines and 180,000 payments.
