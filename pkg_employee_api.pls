create or replace PACKAGE PKG_EMPLOYEES_API AS 
--------------------------------------------------------------------------------
 --  Package Name: PKG_EMPLOYEES_API
 --
 -- Author         : Widget Ltd
 -- DESCRIPTION  : This package is created in regard to 
 --
 -- MODULES : This package specification comprises of the following modules
 --  
 --            pr_create_employee           : Procedure, creates an employee
 --            pr_change_salary_by_pct      : Procedure, allows the Salary for an Employee to be
 --                                           increased or decreased by a percentage
 --            pr_transfer_employee         : Procedure, allows the transfer of an Employee to a different Department
 --            f_get_salary(pi_employee_id  : Function, return the Salary for an Employee.
 --------------------------------------------------------------------------------
 
  /* Create an appropriate executable database 
     object to allow an Employee to be created 
    */ 
  
  PROCEDURE pr_create_employee(  pi_emp_name      IN employees.employee_name%TYPE, 
                            pi_job_title     IN employees.job_title%TYPE, 
                            pi_Manager_id    IN employees.manager_id%TYPE, 
                            pi_date_hired    IN employees.date_hired%TYPE, 
                            pi_salary        IN employees.salary%TYPE, 
                            pi_department_id IN employees.department_id%TYPE);
  /*
    Create an appropriate executable database object to allow the Salary for an
    Employee to be increased or decreased by a percentage
   */
   
   PROCEDURE pr_change_salary_by_pct(pi_employee_id IN employees.employee_id%TYPE
                                    ,pi_sal_pct IN NUMBER);

  /*
       Create an appropriate executable database object to allow the transfer of an
       Employee to a different Department
    */
    
   PROCEDURE pr_transfer_employee(pi_employee_id IN employees.employee_id%TYPE,pi_department_id IN departments.department_id%TYPE);
      
   
   /*
       Create an appropriate executable database object to return the Salary for an
       Employee.
     */

  FUNCTION f_get_salary(pi_employee_id IN employees.employee_id%TYPE) RETURN employees.salary%TYPE;

  
END PKG_EMPLOYEES_API;
/
SHOW ERRORS
/