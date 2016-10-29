#!/bin/bash

FOLDER=.

python $FOLDER/scripts/cleaner.py clean $FOLDER/data/Categorias.txt           $FOLDER/temp/categorias.txt
python $FOLDER/scripts/cleaner.py clean $FOLDER/data/Clientes.txt             $FOLDER/temp/clientes.txt
python $FOLDER/scripts/cleaner.py clean $FOLDER/data/Companias_de_envios.txt  $FOLDER/temp/companiasDeEnvios.txt
python $FOLDER/scripts/cleaner.py clean $FOLDER/data/Detalles_de_pedidos.txt  $FOLDER/temp/detallesDePedidos.txt
python $FOLDER/scripts/cleaner.py clean $FOLDER/data/Empleados.txt            $FOLDER/temp/empleados.txt
python $FOLDER/scripts/cleaner.py clean $FOLDER/data/Pedidos.txt              $FOLDER/temp/pedidos.txt
python $FOLDER/scripts/cleaner.py clean $FOLDER/data/Productos.txt            $FOLDER/temp/productos.txt
python $FOLDER/scripts/cleaner.py clean $FOLDER/data/Proveedores.txt          $FOLDER/temp/proveedores.txt

python $FOLDER/scripts/cleaner.py convert_price $FOLDER/temp/productos.txt

