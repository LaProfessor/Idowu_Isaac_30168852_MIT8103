CUSTOMER-HISTORY QUERY OPTIMISATION

The query filters orders by customer_id and returns the newest ten.
Before indexing, PostgreSQL used a parallel sequential scan followed
by sorting. The composite B-tree index on
(customer_id, ordered_at DESC) allowed an ordered index scan and
early stopping after ten rows.

STUDENT-RUN VERIFICATION

I executed the same EXPLAIN (ANALYZE, BUFFERS) query before and
after creating orders_customer_date_idx and refreshing statistics
with ANALYZE.

Before indexing:
- Parallel sequential scan followed by sorting.
- Execution time: 13.326 ms.
- Top-level execution buffers: 1,311 shared hits.

After indexing:
- Index scan using orders_customer_date_idx.
- Execution time: 0.131 ms.
- Top-level execution buffers: 10 shared hits and 3 shared reads.

This was approximately a 102-fold improvement in one comparison.
These are single-run measurements, not averages or production
performance predictions. Cache state and system load affect timings.
Indexes also require storage and maintenance during writes.

Student evidence:
Idowu_Isaac_30168852_StudentBeforeIndex.txt
Idowu_Isaac_30168852_StudentAfterIndex.txt
Idowu_Isaac_30168852_StudentQueryResults.txt

INITIAL ASSISTANT-RUN MEASUREMENTS

BeforePlan.json, AfterPlan.json and Measurements.json contain the
initial assistant-run evidence. That measurement procedure used one
warm-up followed by five measured executions for each condition.
Measurements.json records server execution times in milliseconds,
excluding client process startup. Index construction and ANALYZE
were outside the timings.
