#!/bin/bash

python scripts/cleaner.py "data/Categorias.txt" "temp/categories.txt"
python scripts/cleaner.py "data/Clientes.txt" "temp/clients.txt"
python scripts/cleaner.py "data/Companias de envios.txt" "temp/shippingCompanies.txt"
python scripts/cleaner.py "data/Detalles de pedidos.txt" "temp/orderDetails.txt"
python scripts/cleaner.py "data/Empleados.txt" "temp/employees.txt"
python scripts/cleaner.py "data/Pedidos.txt" "temp/orders.txt"
python scripts/cleaner.py "data/Productos.txt" "temp/products.txt"
python scripts/cleaner.py "data/Proveedores.txt" "temp/providers.txt"

