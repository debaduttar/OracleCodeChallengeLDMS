-- Insert departments records

INSERT INTO DEPARTMENTS (department_id,Department_name,location) values (deptseq.nextval,'Management','London');
INSERT INTO DEPARTMENTS (department_id,Department_name,location) values (deptseq.nextval,'Engineering','Cardiff');
INSERT INTO DEPARTMENTS (department_id,Department_name,location) values (deptseq.nextval,'Research '||'&'||'Development','Edinburgh');
INSERT INTO DEPARTMENTS (department_id,Department_name,location) values (deptseq.nextval,'Sales','Belfast');

-- Insert Employees records
INSERT INTO EMPLOYEES (employee_id,employee_name,job_title,manager_id,date_hired,salary,department_id) 
   VALUES (empseq.nextval, 'John Smith','CEO',null,to_date('01/01/1995','dd/mm/yyyy'),100000,1);
   
INSERT INTO EMPLOYEES (employee_id,employee_name,job_title,manager_id,date_hired,salary,department_id) 
   VALUES (empseq.nextval, 'Jimmy Willis','Manager',90001,to_date('23/09/2003','dd/mm/yyyy'),52500,4);

INSERT INTO EMPLOYEES (employee_id,employee_name,job_title,manager_id,date_hired,salary,department_id) 
   VALUES (empseq.nextval, 'Roxy Jones','Salesperson',90002,to_date('11/02/2017','dd/mm/yyyy'),35000,4);

INSERT INTO EMPLOYEES (employee_id,employee_name,job_title,manager_id,date_hired,salary,department_id) 
   VALUES (empseq.nextval, 'Selwyn Field','Salesperson',90003,to_date('20/05/2015','dd/mm/yyyy'),32000,4);

INSERT INTO EMPLOYEES (employee_id,employee_name,job_title,manager_id,date_hired,salary,department_id) 
   VALUES (empseq.nextval, 'David Hallett','Engineer',null,to_date('17/04/2018','dd/mm/yyyy'),40000,2);

INSERT INTO EMPLOYEES (employee_id,employee_name,job_title,manager_id,date_hired,salary,department_id) 
   VALUES (empseq.nextval, 'Sarah Phelps','Manager',90001,to_date('21/03/2015','dd/mm/yyyy'),45000,2);
   
INSERT INTO EMPLOYEES (employee_id,employee_name,job_title,manager_id,date_hired,salary,department_id) 
   VALUES (empseq.nextval, 'Sarah Phelps','Manager',90001,to_date('21/03/2015','dd/mm/yyyy'),45000,2);

INSERT INTO EMPLOYEES (employee_id,employee_name,job_title,manager_id,date_hired,salary,department_id) 
   VALUES (empseq.nextval, 'Louise Harper','Engineer',90006,to_date('01/01/2013','dd/mm/yyyy'),47000,2);

INSERT INTO EMPLOYEES (employee_id,employee_name,job_title,manager_id,date_hired,salary,department_id)
   VALUES (empseq.nextval, 'Tina Hart','Engineer',null,to_date('28/07/2014','dd/mm/yyyy'),45000,3);

INSERT INTO EMPLOYEES (employee_id,employee_name,job_title,manager_id,date_hired,salary,department_id) 
   VALUES (empseq.nextval, 'Gus Jones','Manager',90001,to_date('15/05/2018','dd/mm/yyyy'),50000,3);

INSERT INTO EMPLOYEES (employee_id,employee_name,job_title,manager_id,date_hired,salary,department_id) 
   VALUES (empseq.nextval, 'Mildred Hall','Secretary',90001,to_date('12/10/1996','dd/mm/yyyy'),35000,1);


Update employees set manager_id = 90006 where employee_id = 90005;

Update employees set manager_id = 90009 where employee_id = 90008;

Commit;