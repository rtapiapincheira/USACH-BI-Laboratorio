@echo off
osql -E -S(local) -drenetapia_db1 -iC:\workingdirectory\scripts\create_tables_sqlserver.sql
@echo on
