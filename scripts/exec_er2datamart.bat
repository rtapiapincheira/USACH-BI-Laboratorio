@echo off
osql -E -S(local) -drenetapia_db1 -iC:\workingdirectory\scripts\er2datamart.sql
@echo on
