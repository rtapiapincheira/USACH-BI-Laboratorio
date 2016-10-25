@echo off
python %1\scripts\cleaner.py %1\data\Categorias.txt           %1%\temp\categories.txt
python %1\scripts\cleaner.py %1\data\Clientes.txt             %1%\temp\clients.txt
python %1\scripts\cleaner.py %1\data\Companias de envios.txt  %1%\temp\shippingCompanies.txt
python %1\scripts\cleaner.py %1\data\Detalles de pedidos.txt  %1%\temp\orderDetails.txt
python %1\scripts\cleaner.py %1\data\Empleados.txt            %1%\temp\employees.txt
python %1\scripts\cleaner.py %1\data\Pedidos.txt              %1%\temp\orders.txt
python %1\scripts\cleaner.py %1\data\Productos.txt            %1%\temp\products.txt
python %1\scripts\cleaner.py %1\data\Proveedores.txt          %1%\temp\providers.txt
@echo on
