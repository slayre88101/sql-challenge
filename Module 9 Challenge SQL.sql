-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/DQnxbO
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Dept_EMP" (
    "emp_no" INT  NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Dept_EMP" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "Titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "Dept_Manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    CONSTRAINT "pk_Dept_Manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
    "salary" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

ALTER TABLE "Dept_EMP" ADD CONSTRAINT "fk_Dept_EMP_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_EMP" ADD CONSTRAINT "fk_Dept_EMP_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

SELECT "Employees"."emp_no", "Employees"."first_name", "Employees"."last_name", "Employees"."sex", "Salaries"."salary"
FROM "Employees"
JOIN "Salaries" ON "Employees"."emp_no" = "Salaries"."emp_no";

SELECT "emp_no","first_name", "last_name","hire_date"
FROM "Employees" 
WHERE "hire_date" BETWEEN '1986-01-01' AND '1986-12-31';

SELECT  "Dept_Manager"."dept_no","Departments"."dept_name","Dept_Manager"."emp_no","Employees"."last_name","Employees"."first_name"
FROM "Dept_Manager" AS "Dept_Manager"
JOIN "Departments" AS "Departments" ON ( "Dept_Manager"."dept_no" = "Departments"."dept_no")
JOIN "Employees" AS "Employees" ON ("Dept_Manager"."emp_no" = "Employees"."emp_no");

SELECT  "Employees"."emp_no","Employees"."last_name","Employees"."first_name","Departments"."dept_name"
FROM "Employees" AS "Employees"
JOIN "Dept_EMP" AS "Dept_EMP" ON ("Employees"."emp_no" = "Dept_EMP"."emp_no")
JOIN "Departments" AS "Departments" ON ("Dept_EMP"."dept_no" = "Departments"."dept_no")
ORDER BY "Employees"."emp_no";

SELECT first_name, last_name, birth_date, sex
FROM "Employees"
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

SELECT  "Employees"."emp_no","Employees"."last_name","Employees"."first_name","Departments"."dept_name"
FROM "Employees" AS "Employees"
JOIN "Dept_EMP" AS "Dept_EMP" ON ("Employees"."emp_no" = "Dept_EMP"."emp_no")
JOIN "Departments" AS "Departments" ON ("Departments"."dept_no" = "Departments"."dept_no")
WHERE "Departments"."dept_name" = 'Sales'
ORDER BY "Employees"."emp_no";

SELECT  "Employees"."emp_no","Employees"."last_name","Employees"."first_name","Departments"."dept_name"
FROM "Employees" AS "Employees"
JOIN "Dept_EMP" AS "Dept_EMP" ON ("Employees"."emp_no" = "Dept_EMP"."emp_no")
JOIN "Departments" AS "Departments" ON ("Dept_EMP"."dept_no" = "Departments"."dept_no")
WHERE "Departments"."dept_name" IN ('Sales', 'Development')
ORDER BY "Employees"."emp_no";

SELECT last_name, COUNT(last_name)
FROM  "Employees"
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;

