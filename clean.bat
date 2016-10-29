@echo off
python %1\scripts\cleaner.py clean %1\data\Categorias.txt           %1\temp\categorias.txt
python %1\scripts\cleaner.py clean %1\data\Clientes.txt             %1\temp\clientes.txt
python %1\scripts\cleaner.py clean %1\data\Companias_de_envios.txt  %1\temp\companiasDeEnvios.txt
python %1\scripts\cleaner.py clean %1\data\Detalles_de_pedidos.txt  %1\temp\detallesDePedidos.txt
python %1\scripts\cleaner.py clean %1\data\Empleados.txt            %1\temp\empleados.txt
python %1\scripts\cleaner.py clean %1\data\Pedidos.txt              %1\temp\pedidos.txt
python %1\scripts\cleaner.py clean %1\data\Productos.txt            %1\temp\productos.txt
python %1\scripts\cleaner.py clean %1\data\Proveedores.txt          %1\temp\proveedores.txt

python %1\scripts\cleaner.py convert_price %1\temp\productos.txt
python %1\scripts\cleaner.py convert_price %1\temp\pedidos.txt
python %1\scripts\cleaner.py convert_price %1\temp\detallesDePedidos.txt

@echo on
