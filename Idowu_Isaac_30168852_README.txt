ISAACMART ADVANCED DATABASE SYSTEMS PORTFOLIO

Student: Idowu Isaac
Student ID: 30168852
Course: MIT 8103 Advanced Database Systems

Repository:
https://github.com/LaProfessor/Idowu_Isaac_30168852_MIT8103

STATUS
AI-assisted portfolio with guided student verification completed in
GitHub Codespaces. Student-run evidence was committed and pushed in
commit bf95174. Assessor access and final submission checks remain pending.

CASE STUDY
IsaacMart is a simulated Nigerian e-commerce retailer. PostgreSQL
stores customers, products, orders, order items and payments.
MongoDB stores flexible product catalogue attributes.
All sample data is synthetic.

CONTENTS
portfolio-1-database-design:
Schema, sample data, ER diagram and normalisation explanation.

portfolio-2-query-optimisation:
SQL queries, execution plans, indexing and performance analysis.

portfolio-3-transactions-concurrency:
Commit, rollback, checkout, locking and isolation examples.

portfolio-4-nosql:
MongoDB catalogue implementation and suitability explanation.

portfolio-5-distributed-cloud:
Discussion of replication, sharding, availability and consistency.
No distributed cluster or cloud deployment was implemented.

documentation:
Summary PDF and Word document, reflection, AI declaration,
references, integrity checks and student verification evidence.

STUDENT VERIFICATION
I ran the following checks in GitHub Codespaces with AI guidance:

- Created the schema and loaded the synthetic data.
- Confirmed 10,000 customers, 1,000 products, 200,000 orders,
  200,000 order items and 180,000 payments.
- Compared customer-history execution plans before and after indexing.
  Execution time changed from 13.326 ms to 0.131 ms in one comparison.
- Executed the SQL queries; payment reconciliation returned zero mismatches.
- Verified commit and rollback, restoring product 1 stock to 98.
- Demonstrated a two-session row-lock timeout.
- Observed repeatable-read values of 100, 100 and then 101 after commit.
  Restored product 2 stock to 100 afterward.
- Ran the MongoDB example: three documents, successful query/update,
  duplicate-SKU rejection and schema-validation rejection.
- Passed checks for negative stock, missing customer references,
  duplicate email, record counts and transaction final state.

Student-prefixed files contain my saved execution outputs.
The full first-session isolation sequence was shared during guided
verification; its saved final-state file records the final value only.
Original assistant-run evidence is retained separately.

REPRODUCING THE EXAMPLES
Requires Docker. Run commands from the repository root.
Use a fresh demonstration database; Schema.sql resets the isaacmart
schema and deletes any existing data in that schema.

1. Start PostgreSQL:
docker run -d --name isaacmart-pg -e POSTGRES_PASSWORD=portfolio_local_only postgres:17

2. Check readiness:
docker exec isaacmart-pg pg_isready -U postgres

3. Create tables:
docker exec -i isaacmart-pg psql -U postgres -v ON_ERROR_STOP=1 < portfolio-1-database-design/Idowu_Isaac_30168852_Schema.sql

4. Load sample data:
docker exec -i isaacmart-pg psql -U postgres -v ON_ERROR_STOP=1 < portfolio-1-database-design/Idowu_Isaac_30168852_Seed.sql

5. Follow the activity READMEs for queries, before/after index plans,
transactions and two-session concurrency/isolation tests.
Capture the before-index plan before applying Index.sql.
Run the transaction example once when checking its expected stock values.

6. Start MongoDB:
docker run -d --name isaacmart-mongo mongo:8

7. Check readiness:
docker exec isaacmart-mongo mongosh --quiet --eval "db.adminCommand({ping:1})"

8. Run the catalogue example:
docker exec -i isaacmart-mongo mongosh --quiet < portfolio-4-nosql/Idowu_Isaac_30168852_Catalog.js

The catalogue script replaces its demonstration collection.
Container names must be available before running docker run.
The PostgreSQL password is a development-only example.
No host database ports are published.

AI USE
OpenAI ChatGPT/Codex assisted with the initial implementation, documentation, testing guidance and review. I subsequently ran the verification exercises in my Codespace with that guidance.


