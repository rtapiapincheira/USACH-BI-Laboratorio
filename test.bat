set FOLDER=E:\USACH-BI-Laboratorio

python %FOLDER%\scripts\insert_builder.py %FOLDER%\temp\categories.txt        %FOLDER%\temp\insert_categories.sql   %FOLDER%\mappings.txt      categories
python %FOLDER%\scripts\insert_builder.py %FOLDER%\temp\clients.txt           %FOLDER%\temp\insert_clients.sql      %FOLDER%\mappings.txt      clients
python %FOLDER%\scripts\insert_builder.py %FOLDER%\temp\employees.txt         %FOLDER%\temp\insert_employees.sql    %FOLDER%\mappings.txt      employees
python %FOLDER%\scripts\insert_builder.py %FOLDER%\temp\orderDetails.txt      %FOLDER%\temp\insert_orderDetails.sql %FOLDER%\mappings.txt      orderDetails
python %FOLDER%\scripts\insert_builder.py %FOLDER%\temp\orders.txt            %FOLDER%\temp\insert_orders.sql       %FOLDER%\mappings.txt      orders
python %FOLDER%\scripts\insert_builder.py %FOLDER%\temp\products.txt          %FOLDER%\temp\insert_products.sql     %FOLDER%\mappings.txt      products
python %FOLDER%\scripts\insert_builder.py %FOLDER%\temp\providers.txt         %FOLDER%\temp\insert_providers.sql    %FOLDER%\mappings.txt      providers
python %FOLDER%\scripts\insert_builder.py %FOLDER%\temp\shippingCompanies.txt %FOLDER%\temp\insert_shippingCompanies.sql %FOLDER%\mappings.txt shippingCompanies
