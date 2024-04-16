-- Reset the environment
Prompt 'Clearing objects

-- Troncate tables
TRUNCATE table Employees;

TRUNCATE table departments;

-- Drop Sequences
DROP sequence DEPTSEQ;
DROP sequence EMPSEQ;

-- Drop Tables

DROP table Employees;

DROP table departments;


-- drop the package specification

DROP PACKAGE BODY pkg_employees_api ;

-- drop the package body

DROP PACKAGE pkg_employees_api ;

Prompt 'objects Cleared 

