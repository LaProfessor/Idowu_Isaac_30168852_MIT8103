ISAACMART ADVANCED DATABASE SYSTEMS PORTFOLIO
Student: Idowu Isaac | Student ID: 30168852 | MIT 8103
Status: tested assistant-prepared learning portfolio; student review and GitHub publication pending.
GitHub account requested: https://github.com/LaProfessor
Repository URL: NOT CREATED. Replace this with the actual private repository URL before submission.

CONTENTS
Five portfolio folders hold scripts, README explanations and actual text/JSON evidence. documentation contains the three-page summary in PDF and editable DOCX, references, AI declaration, reflection prompts and review checklist. Every uploaded file uses the required Idowu_Isaac_30168852 prefix. Per-activity subfolders use the brief's suggested structure; the submission root uses the exact required student naming.

REPRODUCE
Requires Docker and Python 3 for the optional automated evidence harness. No host database ports are published. Development containers are disposable; do not use real data.
1. docker run -d --name isaacmart-pg -e POSTGRES_PASSWORD=portfolio_local_only postgres:17
2. Wait until: docker exec isaacmart-pg pg_isready -U postgres
3. docker exec -i isaacmart-pg psql -U postgres -v ON_ERROR_STOP=1 < portfolio-1-database-design/Idowu_Isaac_30168852_Schema.sql
4. Run Seed.sql in the same way. Run Queries.sql and EXPLAIN (ANALYZE,BUFFERS) for the history query before Index.sql, then apply Index.sql, ANALYZE isaacmart.orders, and repeat the plan. Capture your own results.
5. Run Transactions.sql and Checkout.sql in the same way. Follow ConcurrencySessions.txt in two terminals; follow Isolation.sql in two sessions.
6. docker run -d --name isaacmart-mongo mongo:8
7. docker exec -i isaacmart-mongo mongosh --quiet < portfolio-4-nosql/Idowu_Isaac_30168852_Catalog.js
8. Read the distributed/cloud discussion; deployment is not required by this selected route and none is claimed.
9. When finished, remove only these demo containers: docker rm -f isaacmart-pg isaacmart-mongo
The PostgreSQL password is a public development-only example. No database port is exposed. Set real credentials securely for any network deployment.

GITHUB
Create a PRIVATE repository under LaProfessor, suggested name Idowu_Isaac_30168852_MIT8103. Upload the root contents, preserving the folders. Add the assessor using their verified GitHub username, then confirm they can access it. Replace the summary's repository placeholder. Commit subsequent real changes progressively with honest dates; do not fabricate semester-long history. A new repository today cannot retroactively meet continuous-development evidence. GitHub may not auto-display the prefixed README; open this file explicitly.

SUBMISSION
Review the three-page summary, replace repository and reflection placeholders, and update the AI declaration with your actual verification. Follow the LMS Google Form's accepted file formats and upload fields; these have not been inspected. Do not assume a ZIP is an accepted form attachment. The ZIP is a convenient delivery package. Submit only once after checking assessor access and the actual form requirements.
