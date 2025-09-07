RESTORE FILELISTONLY 
FROM DISK = '/var/opt/mssql/backup/AdventureWorks2019.bak';

RESTORE DATABASE AdventureWorks2019
FROM DISK = '/var/opt/mssql/backup/AdventureWorks2019.bak'
WITH MOVE 'AdventureWorks2019' TO '/var/opt/mssql/data/AdventureWorks2019.mdf',
     MOVE 'AdventureWorks2019_log' TO '/var/opt/mssql/data/AdventureWorks2019.ldf',
     REPLACE;
