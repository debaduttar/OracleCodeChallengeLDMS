-- ***********************************************************************
-- *
-- * Program         : RepEmployee4Dept.sql
-- * Purpose         : Report to show Total salary of Employees for a Department
-- *                      
-- * Parameters      : Department   - Department Id. IF nothing entered then 
-- *                   show all the employees
-- * Remarks         : Run the report in the SQLPLUS prompt by running the following command:
-- *                   @RepEmpSalary4Dept
-- ***********************************************************************


    REM Whenever there is a sql error, rollback and then exit
    REM -----------------------------------------------------
    REM
    
    WHENEVER sqlerror exit
    
    
    CLEAR COLUMNS
    CLEAR COMPUTES
    CLEAR BREAKS
    
    set feedback off
    set echo off
    set verify off
    set heading on
    set define ON
    
    TTITLE LEFT 'Date: 16/04/2024' RIGHT 'PAGE: ' FORMAT 999 SQL.PNO SKIP 2 -
    CENTER 'Employee Details Report for Department(s) Report' SKIP 2
    
    PROMPT
    PROMPT
    Prompt 'Enter a Valid Department Id. None/Null for all'
    PROMPT '----------------------------------------------'
    PROMPT
    PROMPT
    
    -- Accept the department id
    
    Input 
    
    Accept department prompt 'Department Id:' 
    
    VARIABLE l_dept NUMBER ;
    
    EXEC :l_dept := '&department'
    
    BTITLE CENTER 'END OF THE REPORT' SKIP 2
    
    Break on department
    COMPUTE SUM OF SALARY ON DEPARTMENT
    
    Column Department for a30
    Column EmpName    for a30
    Column JobTitle   for a20
    Column Mgrname    for a20
    Column HiredDate  for a12
    Column EmpId      for 99999
    
    Break on department SKIP 1
    
    set pages 30
    SET newpage 0
    set LINESIZE 150
    
    -- Send the output of the query to EmpDeptReport.Lst in the current directory.
    
    SPOOL RepEmpSalary4Dept
    
    -- Query for fetching all the employees
    
    SELECT
        dep.department_name                    department,
        emp.employee_id                        empid,
        emp.employee_name                      empname,
        emp.job_title                          jobtitle,
        TO_DATE(emp.date_hired, 'DD-MON-YYYY') hireddate,
        emp.salary,
        mgr.employee_name                      mgrname
    FROM
             employees emp
        JOIN departments dep ON emp.department_id = dep.department_id
        LEFT JOIN employees   mgr ON mgr.employee_id = emp.manager_id
    WHERE
        dep.department_id LIKE '%&department%'
    ORDER BY
        dep.department_id,
        emp.employee_id;
    
    
    SPOOL OFF
    
    set feedback off
    set echo off
    set verify off

