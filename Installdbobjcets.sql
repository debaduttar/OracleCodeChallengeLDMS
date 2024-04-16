-- Create tables
SPOOL installobjects.lst

Prompt 'Creating DDL objects '
@Create_objects.sql
Prompt 'DDL objects Created'

Prompt 'Creating records in Departments and Employees table'
@InsertRecords.sql
Prompt 'Records in Departments and Employees table created'

Spool off;