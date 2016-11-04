
delete from dm_ventas;
delete from dm_ciudades;
delete from dm_paises;
delete from dm_productos;
delete from dm_proveedores;
delete from dm_categorias;
delete dm_fechas;
delete dm_empleados;
delete dm_compania_envios;

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
select pais from empleados union
select paisDestinatario as pais from pedidos 
order by pais asc;

-- ciudades
declare @country_name varchar(100)
declare @city_name varchar(100)
declare @country_id int

declare my_cursor_ciudad cursor
 local static read_only forward_only
for
  select pais,ciudad from proveedores union
  select pais,ciudad from clientes union
  select pais,ciudad from empleados union
  select paisDestinatario as pais, ciudadDestinatario as ciudad from pedidos
  
open my_cursor_ciudad
fetch next from my_cursor_ciudad into @country_name, @city_name
while @@fetch_status = 0
begin
  set @country_id = (select id_pais from dm_paises where nombre = @country_name)

  --print cast(@city_name as varchar) + ' ' + cast(@country_id as varchar)
  
  insert into dm_ciudades(nombre,id_pais) values(@city_name, @country_id)

  fetch next from my_cursor_ciudad into @country_name, @city_name
end


-- productos
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
    where nombre = @categorias_nombre and descripcion = @categorias_descripcion
  )

--   print 
--    cast(@proveedores_id as varchar) + ' # ' +
--    cast(@categorias_id as varchar) + ' # ' +
--
--    cast(@productos_nombre as varchar) + ' # ' +
--    cast(@productos_precio_unidad as varchar) + ' # ' +
--    cast(@productos_unidades_stock as varchar) + ' # ' +
--    cast(@productos_unidades_pedido as varchar) + ' # ' +
--
--    cast(@proveedores_nombre_compania as varchar) + ' # ' +
--    cast(@proveedores_nombre_contacto as varchar) + ' # ' +
--    cast(@proveedoreS_cargo_contacto as varchar) + ' # ' +
--
--    cast(@categorias_nombre as varchar) + ' # ' +
--    cast(@categorias_descripcion as varchar) + ' # '
--;

  insert into dm_productos(
    nombre,
    precio_unidad,
    unidades_stock,
    unidades_pedido,
    id_proveedor,
    id_categoria
  ) values
  (
    @productos_nombre,
    @productos_precio_unidad,
    @productos_unidades_stock,
    @productos_unidades_pedido,
    @proveedores_id,
    @categorias_id
  );

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


-- fechas

insert into dm_fechas(ano,mes,dia)
select distinct
    datepart(yyyy, fechaPedido) as ano,
    datepart(mm, fechaPedido) as mes,
    datepart(dd, fechaPedido) as dia
from pedidos
order by ano, mes, dia asc
;


-- ventas

declare @fecha_id int
declare @fecha_ano int
declare @fecha_mes int
declare @fecha_dia int

declare @emp_id int
declare @emp_nombre varchar(100)
declare @emp_apellidos varchar(100)
declare @emp_cargo varchar(100)

declare @pais_id int
declare @ciudad_id int
declare @ciudad_nombre varchar(100)
declare @ciudad_nombre_pais varchar(100)

declare @cliente_id varchar(100)

declare @compania_envio_id int
declare @compania_envio_nombre varchar(100)

declare @producto_id int
  declare @categoria_id int
      declare @categoria_nombre varchar(100)
      declare @categoria_descripcion varchar(1000)
  declare @proveedor_id int
      declare @proveedor_nombre_compania varchar(100)
      declare @proveedor_nombre_contacto varchar(100)
      declare @proveedor_cargo_contacto varchar(100)
declare @producto_nombre varchar(100)
declare @producto_precio_unidad decimal(10,2)
declare @producto_stock int
declare @producto_pedidos int

declare @venta_cantidad int
declare @venta_stock int
declare @venta_pedidos int
declare @venta_total decimal(10,2)

declare my_cursor_venta cursor
 local static read_only forward_only
for
select
    datepart(yyyy, p.fechaPedido) as fecha_ano,
    datepart(mm, p.fechaPedido) as fecha_mes,
    datepart(dd, p.fechaPedido) as fecha_dia,
    
    emp.nombre as emp_nombre,
    emp.apellidos as emp_apellidos,
    emp.cargo as emp_cargo,
    
    p.ciudadDestinatario as ciudad,
    p.paisDestinatario as pais,
    
    p.idCliente as cliente,
    
    cde.nombreCompania as nombre_compania,

    c.nombreCategoria as nombre_categoria,
    c.descripcion as descripcion_categoria,
    
    pr.nombreProducto as producto_nombre,
    pr.precioUnidad as producto_precio_unidad,
    pr.unidadesEnExistencia as producto_stock,
    pr.unidadesEnPedido as producto_pedidos,
    
    prov.nombreCompania as proveedor_nombre_compania,
    prov.nombreContacto as proveedor_nombre_contacto,
    prov.cargoContacto as proveedor_cargo_contacto,
    
    dp.cantidad as num_productos,
    pr.unidadesEnExistencia as stock,
    pr.unidadesEnPedido as pedidos,
    dp.cantidad * pr.precioUnidad as venta_total

from detallesDePedidos dp
    join pedidos p on p.idPedido = dp.idPedido
    join productos pr on pr.idProducto = dp.idProducto
    join categorias c on pr.idCategoria = c.idCategoria
    join empleados emp on p.idEmpleado = emp.idEmpleado
    join companiasDeEnvios cde on p.idFormaEnvio = cde.idCompaniaDeEnvio
    join proveedores prov on pr.idProveedor = prov.idProveedor 
order by dp.idPedido asc
;

open my_cursor_venta
fetch next from my_cursor_venta into
    @fecha_ano,
    @fecha_mes,
    @fecha_dia,
    @emp_nombre,
    @emp_apellidos,
    @emp_cargo,
    @ciudad_nombre,
    @ciudad_nombre_pais,
    @cliente_id,
    @compania_envio_nombre,
    @categoria_nombre,
    @categoria_descripcion,
    @producto_nombre,
    @producto_precio_unidad,
    @producto_stock,
    @producto_pedidos,
    @proveedor_nombre_compania,
    @proveedor_nombre_contacto,
    @proveedor_cargo_contacto,
    @venta_cantidad,
    @venta_stock,
    @venta_pedidos,
    @venta_total
    
while @@fetch_status = 0
begin
    set @fecha_id = (
        select id_fecha 
        from dm_fechas
        where
            ano = @fecha_ano and
            mes = @fecha_mes and
            dia = @fecha_dia
    );
    set @emp_id = (
        select id_empleado
        from dm_empleados
        where
            nombre = @emp_nombre and
            apellidos = @emp_apellidos and
            cargo = @emp_cargo
    );
    set @pais_id = (
        select id_pais
        from dm_paises
        where nombre = @ciudad_nombre_pais
    )
    set @ciudad_id = (
        select id_ciudad
        from dm_ciudades
        where
            nombre = @ciudad_nombre and
            id_pais = @pais_id
    );
    set @compania_envio_id = (
        select id_compania_envios
        from dm_compania_envios
        where
            nombre_compania = @compania_envio_nombre
    );
    set @categoria_id = (
        select id_categoria
        from dm_categorias
        where
            nombre = @categoria_nombre and
            descripcion = @categoria_descripcion
    );
    set @proveedor_id = (
        select id_proveedor
        from dm_proveedores
        where
            nombre_compania = @proveedor_nombre_compania and
            nombre_contacto = @proveedor_nombre_contacto and
            cargo_contacto = @proveedor_cargo_contacto
    );
    set @producto_id = (
        select id_producto
        from dm_productos
        where id_categoria = @categoria_id and id_proveedor = @proveedor_id and nombre = @producto_nombre and precio_unidad = @producto_precio_unidad and unidades_stock = @producto_stock and unidades_pedido = @producto_pedidos
    );
    /*
    print
    cast(@fecha_id as varchar) + ' # ' +
    cast(@emp_id as varchar) + ' # ' +
    cast(@ciudad_id as varchar) + ' # ' +
    cast(@cliente_id as varchar) + ' # ' +
    cast(@compania_envio_id as varchar) + ' # ' +
    cast(@producto_id as varchar) + ' # ' +
    cast(@venta_cantidad as varchar) + ' # ' +
    cast(@venta_stock as varchar) + ' # ' +
    cast(@venta_pedidos as varchar) + ' # ' +
    cast(@venta_total as varchar)
    ;
    */
    
  insert into dm_ventas (
    id_fecha,
    id_empleado,
    id_ciudad,
    id_cliente,
    id_compania_envios,
    id_producto,
    num_productos,
    stock,
    pedidos,
    venta_total
  ) values (
    @fecha_id,
    @emp_id,
    @ciudad_id,
    @cliente_id,
    @compania_envio_id,
    @producto_id,
    @venta_cantidad,
    @venta_stock,
    @venta_pedidos,
    @venta_total
  );


fetch next from my_cursor_venta into
    @fecha_ano,
    @fecha_mes,
    @fecha_dia,
    @emp_nombre,
    @emp_apellidos,
    @emp_cargo,
    @ciudad_nombre,
    @ciudad_nombre_pais,
    @cliente_id,
    @compania_envio_nombre,
    @categoria_nombre,
    @categoria_descripcion,
    @producto_nombre,
    @producto_precio_unidad,
    @producto_stock,
    @producto_pedidos,
    @proveedor_nombre_compania,
    @proveedor_nombre_contacto,
    @proveedor_cargo_contacto,
    @venta_cantidad,
    @venta_stock,
    @venta_pedidos,
    @venta_total
end
