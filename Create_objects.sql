-- ***********************************************************************
-- *
-- * Program         : CreateObjects.sql
-- * Purpose         : Script to create database objects:
-- *                    Tables: Employees, Departments, contraints and sequences  
-- * Remarks         : Run the script in the SQLPLUS prompt by running the following command:
-- *                   @create_oobjects.sql
-- ***********************************************************************

-- Please uncomment the following to drop the tables if already created

/*
DROP table departments;
DROP table Employees;
*/


Prompt 'Creating departments table

CREATE TABLE departments (
    department_id   NUMBER(10) NOT NULL,
    department_name VARCHAR2(50) NOT NULL,
    location        VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN departments.department_id IS
    'The unique identifier for the department';

COMMENT ON COLUMN departments.department_name IS
    'The name of the department';

COMMENT ON COLUMN departments.location IS
    'The physical location of
the department';

ALTER TABLE departments ADD CONSTRAINT department_pk PRIMARY KEY ( department_id );

Prompt 'Departments table and primary key constrains created

Prompt 'Creating Employees table

CREATE TABLE employees (
    employee_id              NUMBER(10) NOT NULL,
    employee_name            VARCHAR2(50) NOT NULL,
    job_title                VARCHAR2(50) NOT NULL,
    date_hired               DATE NOT NULL,
    salary                   NUMBER(10) NOT NULL,
    department_id            NUMBER(5) NOT NULL,
    manager_id               NUMBER(10)
);

COMMENT ON COLUMN employees.employee_id IS
    'The unique identifier for the employee';

COMMENT ON COLUMN employees.employee_name IS
    'The name of the employee';

COMMENT ON COLUMN employees.job_title IS
    'The job role undertaken by the employee. Some employees may undertaken the same job role';

COMMENT ON COLUMN employees.date_hired IS
    'The date the employee was hired
';

COMMENT ON COLUMN employees.salary IS
    'Current salary of the employee';

ALTER TABLE employees ADD CONSTRAINT employee_pk PRIMARY KEY ( employee_id );

ALTER TABLE employees
    ADD CONSTRAINT employee_department_fk FOREIGN KEY ( department_id )
        REFERENCES departments ( department_id );

ALTER TABLE employees
    ADD CONSTRAINT employee_employee_fk FOREIGN KEY ( manager_id )
        REFERENCES employees ( employee_id );

Prompt 'Employees table and primary key constrains created

Prompt 'Creating sequences for Employee_id and Department_id 

-- DROP sequence DEPTSEQ;

CREATE SEQUENCE  "DEPTSEQ"  MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;

-- DROP sequence empseq;

CREATE SEQUENCE  "EMPSEQ"  MINVALUE 90001 MAXVALUE 9999999 INCREMENT BY 1 START WITH 90001 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;

Prompt 'Sequences Created


-- Create the package specification

Prompt 'Creating package specification pkg_employee_api

@pkg_employee_api.pls

Prompt 'package specification pkg_employee_api created 

Prompt 'Creating package body pkg_employee_api 
@pkg_employee_api.plb

Prompt 'package body pkg_employee_api created 