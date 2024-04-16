CREATE OR REPLACE 
PACKAGE BODY PKG_EMPLOYEES_API AS
--------------------------------------------------------------------------------
 --  Package Name: PKG_EMPLOYEES_API
 --
 -- Author         : Widget Ltd
 -- DESCRIPTION  : This package is created in regard to 
 --
 -- MODULES : This package Body comprises of the following modules
 --  
 --            pr_create_employee           : Procedure, creates an employee
 --            pr_change_salary_by_pct      : Procedure, allows the Salary for an Employee to be
 --                                           increased or decreased by a percentage
 --            pr_transfer_employee         : Procedure, allows the transfer of an Employee to a different Department
 --            f_get_salary(pi_employee_id  : Function, return the Salary for an Employee.
 --------------------------------------------------------------------------------
 
   -- Declare global Variables
   
    g_strErrMsg             VARCHAR2(512) := '';  -- stores SQLERRM
    
    PROCEDURE pr_create_employee(  pi_emp_name      IN employees.employee_name%TYPE, 
                                pi_job_title     IN employees.job_title%TYPE, 
                                pi_Manager_id    IN employees.manager_id%TYPE, 
                                pi_date_hired    IN employees.date_hired%TYPE, 
                                pi_salary        IN employees.salary%TYPE, 
                                pi_department_id IN employees.department_id%TYPE) IS
    
       --------------------------------------------------------------------------------
        --PROCEDURE NAME : pr_create_employee
        --
        -- DESCRIPTION: This procedure  allow an Employee to be created
        --              in the EMPLOYEES table. Employee_id is created by increamenting
        --              sequence number empseq (empseq.nextval) which starts from 90001
        --
        -- IN PARAMETERS:
        -- pi_emp_name      : Name of the Employee
        -- pi_job_title     : The job role undertaken by the employee. 
        -- pi_Manager_id    : Line manager of the employee
        -- pi_date_hired    : The date the employee was hired
        -- pi_salary        : Current salary of the employee
        -- pi_department_id : Department ID (as created in departments table)
        --                    Each employee must belong to a department
        --
        -- OUT PARAMETERS   : N/A
        --
        -- IN OUT PARAMETERS: N/A
        --
        --
        --------------------------------------------------------------------------------                                                               
            
        BEGIN
           
           g_strErrMsg := NULL;
           
           --check if the department_id exists
           -- if exists then proceed, if not throw an exception
               INSERT INTO employees (
                employee_id,
                employee_name,
                job_title,
                manager_id,
                date_hired,
                salary,
                department_id
            ) VALUES (
                empseq.NEXTVAL,
                pi_emp_name,
                pi_job_title,
                pi_manager_id,
                pi_date_hired,
                pi_salary,
                pi_department_id
            );
           Commit;                                 
                                          
         EXCEPTION 
         WHEN OTHERS then
                g_strErrMsg := NULL;
                g_strErrMsg := substr(SQLERRM,1,512);
             
                dbms_output.put_line('Error in inserting employee record');
                   
                 RAISE_APPLICATION_ERROR(  SQLCODE
                                         , 'Error in inserting employee record '||g_strErrMsg);
         END pr_create_employee;
    
      /*
           Create an appropriate executable database object to return the Salary for an
           Employee.
         */
    
    FUNCTION f_get_salary(pi_employee_id IN employees.employee_id%TYPE) RETURN employees.salary%TYPE
    IS
      --------------------------------------------------------------------------------
        --FUNCTION NAME : f_get_salary
        --
        -- DESCRIPTION: This function returns salary of an employee 
        --
        -- IN PARAMETERS:
        -- pi_employee_id   : Employee Identification number
        --
        -- RETURN   : This function returns Salary of the employee
        --
        --------------------------------------------------------------------------------                                                               
       
       Cursor cur_get_salary (cp_employee_id IN employees.employee_id%TYPE) IS
       SELECT salary 
         from employees
         Where employee_id = cp_employee_id;
     
       employee_does_not_exist	EXCEPTION;
       
       l_salary employees.salary%TYPE := 0; 
      
    BEGIN

         -- get the salary for the employee
         
         OPEN cur_get_salary(pi_employee_id);
         FETCH cur_get_salary INTO  l_salary;
         IF cur_get_salary%NOTFOUND THEN
           RAISE employee_does_not_exist;
         Else
           RETURN l_salary; 
         END IF;  
           
         EXCEPTION 
            WHEN Employee_does_not_exist THEN
                RAISE_APPLICATION_ERROR(-20001,'Employee does not exist, please enter valid employee');
            WHEN OTHERS THEN
                g_strErrMsg := NULL;
                g_strErrMsg := substr(SQLERRM,1,512);
                RAISE_APPLICATION_ERROR(-20000,g_strErrMsg);    
    END f_get_salary;
      
      
       PROCEDURE pr_change_salary_by_pct(pi_employee_id IN employees.employee_id%TYPE
                                        ,pi_sal_pct IN NUMBER) IS
       --------------------------------------------------------------------------------
        --PROCEDURE NAME : pr_change_salary_by_pct
        --
        -- DESCRIPTION: This procedure  allows the Salary for an
        --              Employee to be increased or decreased by a percentage
        --
        -- IN PARAMETERS:
        -- pi_employee_id   : Employee Identification number
        -- pi_sal_pct       : Percentage of salary to be increased/decreased
        --                    pi_sal_pct > 0 => Increase
        --                    pi_sal_pct < 0 => Decrease
        --
        -- OUT PARAMETERS   : N/A
        --
        -- IN OUT PARAMETERS: N/A
        --
        --
        --------------------------------------------------------------------------------                                                                                                
    
       l_salary employees.salary%TYPE := 0; 
       l_sal_pct NUMBER;
           
      BEGIN
    
         -- get the salary for the employee
         l_salary := f_get_salary(pi_employee_id);
         
         -- if pi_sal_pct > 0 then Increase
         -- elsif pi_sal_pct < 0 then decrease
           
         IF NVL(pi_sal_pct,0) <> 0 THEN
              l_sal_pct := l_salary * (pi_sal_pct/100);
              
              l_salary := l_salary+l_sal_pct;
          END IF;  
           
           --
            -- Update slary with new salary
           --
           
           UPDATE employees
           SET salary = l_salary
           WHERE employee_id = pi_employee_id;
           
           Commit;
       EXCEPTION 
        
           WHEN OTHERS THEN
                g_strErrMsg := NULL;
                g_strErrMsg := substr(SQLERRM,1,512);
                RAISE_APPLICATION_ERROR(-20000,g_strErrMsg);    
      END pr_change_salary_by_pct;
    
      /*
           Create an appropriate executable database object to allow the transfer of an Employee to a different Department
        */
        
       PROCEDURE pr_transfer_employee(pi_employee_id IN employees.employee_id%TYPE,pi_department_id IN departments.department_id%TYPE)
       IS
       --------------------------------------------------------------------------------
        --PROCEDURE NAME : pr_transfer_employee
        --
        -- DESCRIPTION: This procedure  allows 
        --              the transfer of an Employee to a different Department
        --
        -- IN PARAMETERS:
        -- pi_employee_id   : Employee Identification number
        -- pi_Department_id : Target Department Id
        --
        -- OUT PARAMETERS   : N/A
        --
        -- IN OUT PARAMETERS: N/A
        --
        --
        --------------------------------------------------------------------------------                                                                                                
        
       transfer_failed Exception ;
       
    BEGIN
       UPDATE EMPLOYEES emp
       SET emp.department_id = pi_department_id
       WHERE emp.employee_id = pi_employee_id
         AND EXISTS (SELECT 1 
                      FROM departments dept
                      WHERE dept.department_id = pi_department_id);
        
        IF SQL%ROWCOUNT = 0 THEN
          RAISE transfer_failed;
        END IF;              
      Commit;
      EXCEPTION
       
            WHEN transfer_failed THEN
                RAISE_APPLICATION_ERROR(-20003,'Transfer Failed, Check for valied Employee/department');
      WHEN OTHERS THEN
                g_strErrMsg := NULL;
                g_strErrMsg := substr(SQLERRM,1,512);
                RAISE_APPLICATION_ERROR(-20000,g_strErrMsg);    
    END pr_transfer_employee;
       
          
  END PKG_EMPLOYEES_API;    
    /  
    
  SHOW ERRORS
    /