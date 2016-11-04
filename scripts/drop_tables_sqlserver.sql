if object_id('dbo.dm_ventas') is not null drop table dbo.dm_ventas;
if object_id('dbo.dm_productos') is not null drop table dbo.dm_productos;
if object_id('dbo.dm_empleados') is not null drop table dbo.dm_empleados;
if object_id('dbo.dm_clientes') is not null drop table dbo.dm_clientes;
if object_id('dbo.dm_categorias') is not null drop table dbo.dm_categorias;
if object_id('dbo.dm_proveedores') is not null drop table dbo.dm_proveedores;
if object_id('dbo.dm_fechas') is not null drop table dbo.dm_fechas;
if object_id('dbo.dm_ciudades') is not null drop table dbo.dm_ciudades;
if object_id('dbo.dm_paises') is not null drop table dbo.dm_paises;
if object_id('dbo.dm_compania_envios') is not null drop table dbo.dm_compania_envios;


-- --------------------------------------------------------------------------------------------------------------------

if object_id('dbo.detallesDePedidos') is not null drop table dbo.detallesDePedidos;
if object_id('dbo.productos') is not null drop table dbo.productos;
if object_id('dbo.pedidos') is not null drop table dbo.pedidos;
if object_id('dbo.categorias') is not null drop table dbo.categorias;
if object_id('dbo.proveedores') is not null drop table dbo.proveedores;
if object_id('dbo.clientes') is not null drop table dbo.clientes;
if object_id('dbo.empleados') is not null drop table dbo.empleados;
if object_id('dbo.companiasDeEnvios') is not null drop table dbo.companiasDeEnvios;
