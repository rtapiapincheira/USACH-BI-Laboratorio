@echo off
osql -E -S(local) -drenetapia_db1 -iC:\workingdirectory\inserts\insert_companiasDeEnvios.sql
osql -E -S(local) -drenetapia_db1 -iC:\workingdirectory\inserts\insert_empleados.sql
osql -E -S(local) -drenetapia_db1 -iC:\workingdirectory\inserts\insert_clientes.sql
osql -E -S(local) -drenetapia_db1 -iC:\workingdirectory\inserts\insert_proveedores.sql
osql -E -S(local) -drenetapia_db1 -iC:\workingdirectory\inserts\insert_categorias.sql
osql -E -S(local) -drenetapia_db1 -iC:\workingdirectory\inserts\insert_pedidos.sql
osql -E -S(local) -drenetapia_db1 -iC:\workingdirectory\inserts\insert_productos.sql
osql -E -S(local) -drenetapia_db1 -iC:\workingdirectory\inserts\insert_detallesDePedidos.sql
@echo on
