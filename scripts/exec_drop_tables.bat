@echo off
osql -E -S(local) -drenetapia_db1 -iC:\workingdirectory\scripts\drop_tables_sqlserver.sql
@echo on
