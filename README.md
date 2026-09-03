Setup: The script drops any existing college_demo database and recreates it fresh, then switches to it with USE.
Department table: A simple lookup table with dept_id (primary key) and a unique, required dept_name.
Student table: Stores roll number (PK), name, email, phone, a dept_id foreign key linking to department, CGPA, and a transaction ID; an index (idx_student_dept) is added on dept_id to speed up department-based queries.
Course table: Stores course ID (PK), course name, and a dept_id foreign key linking each course to a department.
Enrollment table: The many-to-many link between students and courses, with a composite primary key of (roll_no, course_id, semester) — so a student can take the same course again in a different semester, but not twice in the same semester; semester is restricted to values 1–8.
Sample data: Two departments, two students (one per department), two courses (one per department), and two enrollment rows showing student 101 taking both courses in semester 3.
Display queries: A set of SELECT * statements just prints out everything in all four tables to confirm the data loaded correctly.
Transaction isolation demo — Session A: Starts a transaction and updates student 101's CGPA to 9.6, but never commits it.
Transaction isolation demo — Session B: Runs SELECT * FROM student concurrently; whether it sees the new 9.6 or the old 8.50 depends on the isolation level — MySQL's default (repeatable read) keeps uncommitted changes hidden from other sessions.
Query plan check: EXPLAIN SELECT * FROM student WHERE dept_id = 1 reveals whether MySQL uses the idx_student_dept index or a full table scan — with only two rows, the optimizer may pick a full scan anyway since it's faster at that tiny size
