
CREATE TABLE companiasDeEnvios (
  idCompaniaDeEnvio INT NOT NULL,
  nombreCompania VARCHAR(100) NULL,
  telefono VARCHAR(45) NULL,
  PRIMARY KEY (idCompaniaDeEnvio))
;

CREATE TABLE categorias (
  idCategoria INT NOT NULL,
  nombreCategoria VARCHAR(100) NULL,
  descripcion TEXT NULL,
  PRIMARY KEY (idCategoria))
;

CREATE TABLE clientes (
  idCliente VARCHAR(20) NOT NULL,
  nombreCompania VARCHAR(100) NULL,
  nombreContacto VARCHAR(100) NULL,
  cargoContacto VARCHAR(255) NULL,
  direccion TEXT NULL,
  pais VARCHAR(100) NULL,
  ciudad VARCHAR(100) NULL,
  region VARCHAR(45) NULL,
  codPostal VARCHAR(45) NULL,
  telefono VARCHAR(45) NULL,
  fax VARCHAR(45) NULL,
  PRIMARY KEY (idCliente))
;

CREATE TABLE empleados (
  idEmpleado INT NOT NULL,
  apellidos VARCHAR(100) NULL,
  nombre VARCHAR(100) NULL,
  cargo VARCHAR(45) NULL,
  tratamiento VARCHAR(45) NULL,
  fechaNacimiento DATETIME NULL,
  fechaContratacion DATETIME NULL,
  direccion TEXT NULL,
  ciudad VARCHAR(100) NULL,
  region VARCHAR(45) NULL,
  codPostal VARCHAR(45) NULL,
  pais VARCHAR(45) NULL,
  telDomicilio VARCHAR(45) NULL,
  extension VARCHAR(10) NULL,
  foto TEXT NULL,
  notas TEXT NULL,
  jefe VARCHAR(45) NULL,
  PRIMARY KEY (idEmpleado))
;


CREATE TABLE pedidos (
  idPedido INT NOT NULL,
  idCliente VARCHAR(20) NOT NULL,
  idEmpleado INT NOT NULL,
  fechaPedido DATETIME NULL,
  fechaEntrega DATETIME NULL,
  fechaEnvio DATETIME NULL,
  idFormaEnvio INT NOT NULL,
  cargo DECIMAL NULL,
  destinatario VARCHAR(45) NULL,
  direccionDestinatario TEXT NULL,
  ciudadDestinatario VARCHAR(100) NULL,
  regionDestinatario VARCHAR(45) NULL,
  codPostalDestinatario VARCHAR(45) NULL,
  paisDestinatario VARCHAR(45) NULL,
  PRIMARY KEY (idPedido),
  CONSTRAINT fk_pedidos_empleados1
    FOREIGN KEY (idEmpleado)
    REFERENCES empleados (idEmpleado),
  CONSTRAINT fk_pedidos_companiaDeEnvios1
    FOREIGN KEY (idFormaEnvio)
    REFERENCES companiasDeEnvios (idCompaniaDeEnvio))
;


CREATE TABLE proveedores (
  idProveedor INT NOT NULL,
  nombreCompania VARCHAR(100) NULL,
  nombreContacto VARCHAR(100) NULL,
  cargoContacto VARCHAR(45) NULL,
  direccion TEXT NULL,
  ciudad VARCHAR(100) NULL,
  region VARCHAR(45) NULL,
  codPostal VARCHAR(45) NULL,
  pais VARCHAR(45) NULL,
  telefono VARCHAR(45) NULL,
  fax VARCHAR(45) NULL,
  paginaPrincipal TEXT NULL,
  PRIMARY KEY (idProveedor))
;


CREATE TABLE productos (
  idProducto INT NOT NULL,
  idCategoria INT NOT NULL,
  nombreProducto VARCHAR(100) NULL,
  idProveedor INT NOT NULL,
  cantidadPorUnidad VARCHAR(150) NULL,
  precioUnidad DECIMAL(10,2) NULL,
  unidadesEnExistencia INT NULL,
  unidadesEnPedido INT NULL,
  nivelNuevoPedido VARCHAR(45) NULL,
  suspendido TINYINT NULL,
  PRIMARY KEY (idProducto),
  CONSTRAINT fk_productos_categorias
    FOREIGN KEY (idCategoria)
    REFERENCES categorias (idCategoria),
  CONSTRAINT fk_productos_proveedores1
    FOREIGN KEY (idProveedor)
    REFERENCES proveedores (idProveedor))
;


CREATE TABLE detallesDePedidos (
  idPedido INT NOT NULL,
  idProducto INT NOT NULL,
  precioUnidad DECIMAL(10,2) NULL,
  cantidad INT NULL,
  descuento DECIMAL(10,2) NULL,
  CONSTRAINT fk_detallesPedidos_pedidos1
    FOREIGN KEY (idPedido)
    REFERENCES pedidos (idPedido),
  CONSTRAINT fk_detallesPedidos_productos1
    FOREIGN KEY (idProducto)
    REFERENCES productos (idProducto))
;


-- -------- Datamart tables

create table dm_fechas (
  id_fecha INT NOT NULL identity (1,1),
  dia INT NOT NULL,
  mes INT NOT NULL,
  ano INT NOT NULL,

  primary key (id_fecha)

);

create table dm_paises (
  id_pais INT NOT NULL identity (1,1),
  nombre varchar(100) NOT NULL,

  primary key(id_pais)

);

create table dm_ciudades (
 id_ciudad INT NOT NULL identity (1,1),
 nombre varchar(100) NOT NULL,
 id_pais INT NOT NULL,

 primary key(id_ciudad),

 constraint fk_pais foreign key(id_pais) references dm_paises (id_pais)

);

create table dm_empleados(
  id_empleado INT NOT NULL identity (1,1),
  nombre varchar(100) NOT NULL,
  apellidos varchar(100) NOT NULL,
  cargo varchar(100) NOT NULL,

  primary key(id_empleado)
);

create table dm_compania_envios (
  id_compania_envios INT NOT NULL identity (1,1),
  nombre_compania varchar(100) NOT NULL,

  primary key(id_compania_envios)

);

create table dm_categorias (
  id_categoria INT NOT NULL identity (1,1),
  nombre VARCHAR(100) NOT NULL,
  descripcion VARCHAR(1000) NOT NULL,

  primary key(id_categoria)

);

create table dm_proveedores(
  id_proveedor INT NOT NULL identity (1,1),
  nombre_compania varchar(100) NOT NULL,
  nombre_contacto varchar(100) NOT NULL,
  cargo_contacto varchar(100) NOT NULL,

  primary key(id_proveedor)

);

create table dm_productos (
  id_producto INT NOT NULL identity (1,1),
  id_categoria INT NOT NULL,
  nombre varchar(100) NOT NULL,
  precio_unidad decimal(10,2) NOT NULL,
  unidades_stock INT NOT NULL,
  unidades_pedido INT NOT NULL,
  id_proveedor INT NOT NULL,

  primary key(id_producto),

  constraint fk_proveedor foreign key (id_proveedor) references dm_proveedores (id_proveedor),
  constraint fk_categoria foreign key (id_categoria) references dm_categorias (id_categoria)

);

create table dm_ventas (
 id_fecha INT NOT NULL,
 id_empleado INT NOT NULL,
 id_ciudad INT NOT NULL,
 id_cliente INT NOT NULL,
 id_compania_envios INT NOT NULL,
 id_producto INT NOT NULL,

 num_productos INT NOT NULL,
 stock INT NOT NULL,
 pedidos INT NOT NULL,
 venta_total DECIMAL(10,2),

 primary key(id_fecha, id_empleado, id_ciudad, id_cliente, id_compania_envios, id_producto), /* id_venta */

 constraint fk_fecha foreign key (id_fecha) references dm_fechas (id_fecha),
 constraint fk_empleado foreign key (id_empleado) references dm_empleados (id_empleado),
 constraint fk_ciudad foreign key (id_ciudad) references dm_ciudades (id_ciudad),
 constraint fk_compania_envios foreign key (id_compania_envios) references dm_compania_envios (id_compania_envios),
 constraint fk_producto foreign key (id_producto) references dm_productos (id_producto)

);

