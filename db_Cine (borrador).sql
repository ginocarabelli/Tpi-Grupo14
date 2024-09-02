CREATE DATABASE Cine
GO
USE Cine
GO
CREATE TABLE Paises(
id_pais int identity primary key,
pais varchar(50) not null
)
CREATE TABLE Provincias(
id_provincia int identity primary key,
id_pais int not null,
provincia varchar(50) not null,
CONSTRAINT fk_id_pais FOREIGN KEY (id_pais) REFERENCES Paises(id_pais)
)
CREATE TABLE Localidades(
id_localidad int identity primary key,
id_provincia int not null,
localidad varchar(50) not null,
CONSTRAINT fk_id_provincia FOREIGN KEY (id_provincia) REFERENCES Provincias(id_provincia)
)
CREATE TABLE Barrios(
id_barrio int identity primary key,
id_localidad int not null,
barrio varchar(50) not null,
CONSTRAINT fk_id_localidad FOREIGN KEY (id_localidad) REFERENCES Localidades(id_localidad)
)
CREATE TABLE TiposDocumentos(
id_tipo_documento int identity primary key,
tipo_documento varchar(25) not null
)
CREATE TABLE Clientes(
id_cliente int primary key,
nombre varchar(25) not null,
apellido varchar(25) not null,
id_tipo_documento int not null,
documento int not null,
sexo varchar(1) not null,
CONSTRAINT fk_id_tipo_documento_cliente FOREIGN KEY (id_tipo_documento) REFERENCES TiposDocumentos(id_tipo_documento)
)
CREATE TABLE Sucursales(
id_sucursal int primary key,
id_barrio int not null,
direccion varchar(50) not null,
altura int not null,
razon_social varchar(25) not null,
CONSTRAINT fk_id_barrio_sucursal FOREIGN KEY (id_barrio) REFERENCES Barrios(id_barrio)
)
CREATE TABLE Directores(
id_director int primary key,
nombre varchar(25) not null,
apellido varchar(25) not null,
edad int not null,
)
CREATE TABLE Categorias(
id_categoria int identity primary key,
categoria varchar(10) not null
)
CREATE TABLE Generos(
id_genero int identity primary key,
genero varchar(25) not null
)
CREATE TABLE Idiomas(
id_idioma int identity primary key,
idioma varchar(25) not null
)
CREATE TABLE Peliculas(
id_pelicula int primary key,
titulo varchar(25) not null,
id_director int not null,
duracion time not null,
descripcion varchar(150),
puntuacion decimal(10,2),
id_categoria int not null,
id_genero int not null,
fecha_estreno datetime not null,
id_idioma int not null,
CONSTRAINT fk_id_director_pelicula FOREIGN KEY (id_director) REFERENCES Directores(id_director),
CONSTRAINT fk_id_categoria_pelicula FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria),
CONSTRAINT fk_id_genero_pelicula FOREIGN KEY (id_genero) REFERENCES Generos(id_genero),
CONSTRAINT fk_id_idioma_pelicula FOREIGN KEY (id_idioma) REFERENCES Idiomas(id_idioma)
)
CREATE TABLE Funciones(
id_funcion int primary key,
id_sucursal int not null,
id_pelicula int not null,
fecha date not null,
horario time not null,
CONSTRAINT fk_id_sucursal_funcion FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id_sucursal)
)
CREATE TABLE Empleados(
id_empleado int primary key,
nombre varchar(25) not null,
apellido varchar(25) not null,
id_tipo_documento int not null,
documento int not null,
id_sucursal int not null, 
CONSTRAINT fk_id_tipo_documento_empleado FOREIGN KEY (id_tipo_documento) REFERENCES TiposDocumentos(id_tipo_documento),
CONSTRAINT fk_id_sucursal_empleado FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id_sucursal)
)
CREATE TABLE TiposSalas(
id_tipo_sala int identity primary key,
tipo_sala varchar(10) not null
)
CREATE TABLE Salas(
id_sala int primary key,
id_sucursal int not null,
capacidad int not null,
id_tipo_sala int not null,
CONSTRAINT fk_id_sucursal_sala FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id_sucursal),
CONSTRAINT fk_id_tipo_sala FOREIGN KEY (id_tipo_sala) REFERENCES TiposSalas(id_tipo_sala),
)
CREATE TABLE SalasFunciones(
id_sala_funcion int primary key,
id_sala int not null,
id_funcion int not null,
CONSTRAINT fk_id_funcion_salafuncion FOREIGN KEY (id_funcion) REFERENCES Funciones(id_funcion),
CONSTRAINT fk_id_sala_salafuncion FOREIGN KEY (id_sala) REFERENCES Salas(id_sala)
)
CREATE TABLE Asientos(
id_asiento int primary key,
enumeracion int not null,
fila varchar(1) not null,
id_sala int not null,
CONSTRAINT fk_id_sala_asiento FOREIGN KEY (id_sala) REFERENCES Salas(id_sala)
)
CREATE TABLE Descuentos(
id_descuento int identity primary key,
dia date,
hora time,
porcentaje_descuento decimal(10,2) not null
)
CREATE TABLE FormasPagos(
id_forma_pago int identity primary key,
forma_pago varchar(25) not null
)
CREATE TABLE EstadosReservas(
id_estado_reserva int identity primary key,
estado_reserva varchar(15) not null
)
CREATE TABLE Reservas(
id_reserva int primary key,
id_estado_reserva int not null,
hora_reserva time not null,
id_sala_funcion int not null,
id_asiento int not null
CONSTRAINT fk_id_estado_reserva_reserva FOREIGN KEY (id_estado_reserva) REFERENCES EstadosReservas(id_estado_reserva),
CONSTRAINT fk_id_sala_funcion_reserva FOREIGN KEY (id_sala_funcion) REFERENCES SalasFunciones(id_sala_funcion),
CONSTRAINT fk_id_asiento_reserva FOREIGN KEY (id_asiento) REFERENCES Asientos(id_asiento)
)
CREATE TABLE Facturas(
id_factura int primary key,
id_reserva int,
id_cliente int not null,
id_empleado int,
cantidad_ticket int not null,
id_forma_pago int not null,
CONSTRAINT fk_id_reserva_factura FOREIGN KEY (id_reserva) REFERENCES Reservas(id_reserva),
CONSTRAINT fk_id_forma_pago_factura FOREIGN KEY (id_forma_pago) REFERENCES FormasPagos(id_forma_pago),
CONSTRAINT fk_id_cliente_factura FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
)
CREATE TABLE Tickets(
id_ticket int primary key,
id_factura int not null,
id_sala_funcion int not null,
id_asiento int not null,
id_descuento int,
pre_unitario decimal(10,2) not null,
CONSTRAINT fk_id_sala_funcion_ticket FOREIGN KEY (id_sala_funcion) REFERENCES SalasFunciones(id_sala_funcion),
CONSTRAINT fk_id_descuento_ticket FOREIGN KEY (id_descuento) REFERENCES Descuentos(id_descuento),
CONSTRAINT fk_id_factura_ticket FOREIGN KEY (id_factura) REFERENCES Facturas(id_factura),
CONSTRAINT fk_id_asiento_ticket FOREIGN KEY (id_asiento) REFERENCES Asientos(id_asiento)
)
