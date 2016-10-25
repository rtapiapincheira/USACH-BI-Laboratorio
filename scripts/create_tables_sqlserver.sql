
CREATE TABLE companiaDeEnvios (
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
  idCliente INT NOT NULL,
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
  idCliente INT NOT NULL,
  idEmpleado INT NOT NULL,
  fechaPedido DATETIME NULL,
  fechaEntrega DATETIME NULL,
  fechaEnvio DATETIME NULL,
  idFormaEnvio INT NOT NULL,
  cargo VARCHAR(45) NULL,
  destinatario VARCHAR(45) NULL,
  direccionDestinatario TEXT NULL,
  ciudadDestinatario VARCHAR(100) NULL,
  regionDestinatario VARCHAR(45) NULL,
  codPostalDestinatario VARCHAR(45) NULL,
  paisDestinatario VARCHAR(45) NULL,
  PRIMARY KEY (idPedido),
  CONSTRAINT fk_pedidos_clientes1
    FOREIGN KEY (idCliente)
    REFERENCES clientes (idCliente),
  CONSTRAINT fk_pedidos_empleados1
    FOREIGN KEY (idEmpleado)
    REFERENCES empleados (idEmpleado),
  CONSTRAINT fk_pedidos_companiaDeEnvios1
    FOREIGN KEY (idFormaEnvio)
    REFERENCES companiaDeEnvios (idCompaniaDeEnvio))
;


CREATE TABLE proveedores (
  idProveedor INT NOT NULL,
  nombreCompania VARCHAR(100) NULL,
  nombreContacto VARCHAR(100) NULL,
  cargoContactor VARCHAR(45) NULL,
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
  cantidadPorUnidad INT NULL,
  precioUnidad DECIMAL NULL,
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


CREATE TABLE detallesPedidos (
  idPedido INT NOT NULL,
  idProducto INT NOT NULL,
  precioUnidad DECIMAL NULL,
  cantidad INT NULL,
  descuento DECIMAL NULL,
  CONSTRAINT fk_detallesPedidos_pedidos1
    FOREIGN KEY (idPedido)
    REFERENCES pedidos (idPedido),
  CONSTRAINT fk_detallesPedidos_productos1
    FOREIGN KEY (idProducto)
    REFERENCES productos (idProducto))
;

