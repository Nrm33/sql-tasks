# SQL Tasks Repository

This repository contains SQL scripts and an Entity-Relationship (ER) diagram for creating and managing two related tables: `departments` and `employees`.

---

## **1. Tables Overview**

### **Departments Table**

| Column    | Data Type | Constraints |
| --------- | --------- | ----------- |
| dept_id   | SERIAL    | PRIMARY KEY |
| dept_name | TEXT      | UNIQUE      |

### **Employees Table**

| Column   | Data Type | Constraints                         |
| -------- | --------- | ----------------------------------- |
| emp_id   | SERIAL    | PRIMARY KEY                         |
| emp_name | TEXT      | NOT NULL                            |
| dept_id  | INT       | FOREIGN KEY referencing departments |
| salary   | NUMERIC   |                                     |

---

## **2. Tasks Implemented in SQL Script**

1. Create `departments` and `employees` tables with primary keys.
2. Add a foreign key constraint on `employees.dept_id`.
3. Add a unique constraint on `departments.dept_name`.
4. Create an index on the `salary` column in `employees`.
5. Insert sample data (4–8 rows) in both tables.
6. Select queries using `WHERE`, `NOT IN`, `LIKE`, and `ORDER BY`.
7. Select queries using `GROUP BY` and `HAVING` with `COUNT` and `SUM`.
8. Perform an `INNER JOIN` between the tables.
9. Perform a `LEFT JOIN` between the tables.
10. Insert and update statements with `COMMIT` and `ROLLBACK`.

---

## **3. ER Diagram**

The ER diagram represents the relationship between `departments` and `employees`.
![ER Diagram](ER_diagram.png)

---

## **4. How to Run the SQL Script**

1. Open PostgreSQL terminal:

```bash
psql -U <username> -d <database_name>
```

2. Execute the script:

```sql
\i sql_tasks.sql
```

3. Verify tables and data:

```sql
\dt
SELECT * FROM departments;
SELECT * FROM employees;
```

---

## **5. Notes**

* The script is designed for PostgreSQL.
* Make sure to commit and rollback transactions as needed while running the insert/update statements.

---

This `README` gives a clear overview of your tasks, tables, and ER diagram.

---

If you want, I can also **add a small section with screenshots of outputs and queries**, which makes the repo visually more informative.

Do you want me to do that?
