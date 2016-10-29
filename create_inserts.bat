@echo off
set FOLDER=C:\workingdirectory

python %FOLDER%\scripts\insert_builder.py %FOLDER%\temp\categorias.txt        %FOLDER%\inserts\insert_categorias.sql        %FOLDER%\mappings.txt categorias
python %FOLDER%\scripts\insert_builder.py %FOLDER%\temp\clientes.txt          %FOLDER%\inserts\insert_clientes.sql          %FOLDER%\mappings.txt clientes
python %FOLDER%\scripts\insert_builder.py %FOLDER%\temp\empleados.txt         %FOLDER%\inserts\insert_empleados.sql         %FOLDER%\mappings.txt empleados
python %FOLDER%\scripts\insert_builder.py %FOLDER%\temp\detallesDePedidos.txt %FOLDER%\inserts\insert_detallesDePedidos.sql %FOLDER%\mappings.txt detallesDePedidos
python %FOLDER%\scripts\insert_builder.py %FOLDER%\temp\pedidos.txt           %FOLDER%\inserts\insert_pedidos.sql           %FOLDER%\mappings.txt pedidos
python %FOLDER%\scripts\insert_builder.py %FOLDER%\temp\productos.txt         %FOLDER%\inserts\insert_productos.sql         %FOLDER%\mappings.txt productos
python %FOLDER%\scripts\insert_builder.py %FOLDER%\temp\proveedores.txt       %FOLDER%\inserts\insert_proveedores.sql       %FOLDER%\mappings.txt proveedores
python %FOLDER%\scripts\insert_builder.py %FOLDER%\temp\companiasDeEnvios.txt %FOLDER%\inserts\insert_companiasDeEnvios.sql %FOLDER%\mappings.txt companiasDeEnvios

@echo on