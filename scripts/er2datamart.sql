/*
-- proveedores
insert into dm_proveedores(nombre_compania,nombre_contacto,cargo_contacto)
  select nombreCompania,nombreContacto,cargoContacto
    from proveedores;

-- categorias
insert into dm_categorias(nombre,descripcion)
  select nombreCategoria,descripcion 
    from categorias;

-- compania_envios
insert into dm_compania_envios(nombre_compania)
  select nombreCompania
    from companiasDeEnvios;

-- empleados
insert into dm_empleados(nombre,apellidos,cargo)
  select nombre,apellidos,cargo
    from empleados;

-- paises
insert into dm_paises(nombre)
select pais from proveedores union
select pais from clientes union
select pais from empleados
order by pais asc;

-- ciudades
declare @country_name varchar(100)
declare @city_name varchar(100)
declare @country_id int

declare my_cursor cursor
 local static read_only forward_only
for
  select pais,ciudad from proveedores union
  select pais,ciudad from clientes union
  select pais,ciudad from empleados
  
open my_cursor_ciudad
fetch next from my_cursor_ciudad into @country_name, @city_name
while @@fetch_status = 0
begin
 set @country_id = (select id_pais from dm_paises where nombre = @country_name)
 -- print cast(@country_id as varchar) + ' ' + @country_name + ' ' + @city_name
 insert into dm_ciudades(nombre,id_pais) values(@city_name, @country_id)

 fetch next from my_cursor_ciudad into @country_name, @city_name
end
*/

-- productos
-- select * from dm_proveedores;
-- select * from dm_categorias;
declare @productos_nombre varchar(100)
declare @productos_precio_unidad decimal(10,2)
declare @productos_unidades_stock int
declare @productos_unidades_pedido int

declare @proveedores_id int
declare @proveedores_nombre_compania varchar(100)
declare @proveedores_nombre_contacto varchar(100)
declare @proveedores_cargo_contacto varchar(100)

declare @categorias_id int
declare @categorias_nombre varchar(100)
declare @categorias_descripcion varchar(1000)

declare my_cursor_producto cursor
 local static read_only forward_only
for
  select
	p.nombreProducto,
	p.precioUnidad,
	p.unidadesEnExistencia,
	p.unidadesEnPedido,
	pr.nombreCompania,
	pr.nombreContacto,
	pr.cargoContacto,
	c.nombreCategoria,
	c.descripcion
  from productos p
  join categorias c on p.idCategoria = c.idCategoria
  join proveedores pr on p.idProveedor = pr.idProveedor

open my_cursor_producto
fetch next from my_cursor_producto into
	@productos_nombre,
	@productos_precio_unidad,
	@productos_unidades_stock,
	@productos_unidades_pedido,

	@proveedores_nombre_compania,
	@proveedores_nombre_contacto,
	@proveedoreS_cargo_contacto,

	@categorias_nombre,
	@categorias_descripcion
while @@fetch_status = 0
begin
  set @proveedores_id = (
	select id_proveedor
 	from dm_proveedores
	where nombre_compania = @proveedores_nombre_compania and nombre_contacto = @proveedores_nombre_contacto and cargo_contacto = @proveedores_cargo_contacto
  )
  set @categorias_id = (
	select id_categoria
	from dm_categorias
	where 
  )

  print 
cast(@proveedores_id as varchar) + ' ' +
cast(@categorias_id as varchar) + ' # ' +

cast(@productos_nombre as varchar) + ' ' +
	cast(@productos_precio_unidad as varchar) + ' ' +
	cast(@productos_unidades_stock as varchar) + ' ' +
	cast(@productos_unidades_pedido as varchar) + ' ' +

	cast(@proveedores_nombre_compania as varchar) + ' ' +
	cast(@proveedores_nombre_contacto as varchar) + ' ' +
	cast(@proveedoreS_cargo_contacto as varchar) + ' ' +

	cast(@categorias_nombre as varchar) + ' ' +
	cast(@categorias_descripcion as varchar) + ' '
;
  fetch next from my_cursor_producto into
		@productos_nombre,
		@productos_precio_unidad,
		@productos_unidades_stock,
		@productos_unidades_pedido,

		@proveedores_nombre_compania,
		@proveedores_nombre_contacto,
		@proveedores_cargo_contacto,

		@categorias_nombre,
		@categorias_descripcion
end

