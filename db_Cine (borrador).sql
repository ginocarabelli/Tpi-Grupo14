CREATE DATABASE Cine
GO
USE Cine
GO
CREATE TABLE Paises(
id_pais int identity primary key,
pais varchar(50)
)
CREATE TABLE Provincias(
id_provincia int identity primary key,
id_pais int,
provincia varchar(50),
CONSTRAINT fk_id_pais FOREIGN KEY (id_pais) REFERENCES Paises(id_pais)
)
CREATE TABLE Localidades(
id_localidad int identity primary key,
id_provincia int,
localidad varchar(50),
CONSTRAINT fk_id_provincia FOREIGN KEY (id_provincia) REFERENCES Provincias(id_provincia)
)
CREATE TABLE Barrios(
id_barrio int identity primary key,
id_localidad int,
barrio varchar(50),
CONSTRAINT fk_id_localidad FOREIGN KEY (id_localidad) REFERENCES Localidades(id_localidad)
)
CREATE TABLE TiposDocumentos(
id_tipo_documento int identity primary key,
tipo_documento varchar(25)
)
CREATE TABLE Directores(
id_director int primary key,
nombre varchar(25),
apellido varchar(25),
edad int,
id_tipo_documento int,
documento int,
CONSTRAINT fk_id_tipo_documento FOREIGN KEY (id_tipo_documento) REFERENCES TiposDocumentos(id_tipo_documento)
)
CREATE TABLE Categorias(
id_categoria int identity primary key,
categoria varchar(10)
)
CREATE TABLE Generos(
id_genero int identity primary key,
genero varchar(25)
)
CREATE TABLE Idiomas(
id_idioma int identity primary key,
idioma varchar(25)
)
CREATE TABLE Peliculas(
id_pelicula int primary key,
titulo varchar(25),
id_director int,
duracion int,
descripcion varchar(150),
puntuacion decimal(10,2),
id_categoria int,
id_genero int,
fecha_estreno datetime,
id_idioma int,
CONSTRAINT fk_id_director FOREIGN KEY (id_director) REFERENCES Directores(id_director),
CONSTRAINT fk_id_categoria FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria),
CONSTRAINT fk_id_genero FOREIGN KEY (id_genero) REFERENCES Generos(id_genero),
CONSTRAINT fk_id_idioma FOREIGN KEY (id_idioma) REFERENCES Idiomas(id_idioma)
)
CREATE TABLE Clientes(
id_cliente int primary key,
nombre varchar(25),
apellido varchar(25),
id_tipo_documento int,
documento int,
sexo varchar(1),
CONSTRAINT fk_id_tipo_documento FOREIGN KEY (id_tipo_documento) REFERENCES TiposDocumentos(id_tipo_documento)
)
CREATE TABLE Sucursales(
id_sucursal int primary key,
id_barrio int,
direccion varchar(50),
altura int,
cantidad_salas int,
razon_social varchar(25),
CONSTRAINT fk_id_barrio FOREIGN KEY (id_barrio) REFERENCES Barrios(id_barrio)
)
CREATE TABLE Empleados(
id_empleado int primary key,
nombre varchar(25),
apellido varchar(25),
id_tipo_documento int,
documento int,
id_sucursal int,
CONSTRAINT fk_id_tipo_documento FOREIGN KEY (id_tipo_documento) REFERENCES TiposDocumentos(id_tipo_documento),
CONSTRAINT fk_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id_sucursal)
)
CREATE TABLE TiposSalas(
id_tipo_sala int identity primary key,
tipo_sala varchar(10)
)
CREATE TABLE Salas(
id_sala int primary key,
id_sucursal int,
capacidad int,
id_tipo_sala int,
CONSTRAINT fk_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id_sucursal),
CONSTRAINT fk_id_tipo_sala FOREIGN KEY (id_tipo_sala) REFERENCES TiposSalas(id_tipo_sala),
)
CREATE TABLE Asientos(
id_asiento int primary key,
enumeracion int,
fila varchar(1),
id_sala int,
CONSTRAINT fk_id_sala FOREIGN KEY (id_sala) REFERENCES Salas(id_sala)
)