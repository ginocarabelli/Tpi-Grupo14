CREATE DATABASE Cine
GO
SET DATEFORMAT DMY
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
email varchar(50) not null,
telefono bigint not null,
CONSTRAINT fk_id_tipo_documento_cliente FOREIGN KEY (id_tipo_documento) REFERENCES TiposDocumentos(id_tipo_documento)
)
CREATE TABLE Sucursales(
id_sucursal int primary key,
nombre varchar(50) not null,
id_barrio int not null,
direccion varchar(50) not null,
altura int not null,
CONSTRAINT fk_id_barrio_sucursal FOREIGN KEY (id_barrio) REFERENCES Barrios(id_barrio)
)
CREATE TABLE Directores(
id_director int primary key,
nombre varchar(25) not null,
apellido varchar(25) not null,
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
titulo varchar(50) not null,
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
id_sala_funcion int not null,
FOREIGN KEY (id_sala_funcion) REFERENCES SalasFunciones(id_sala_funcion)
)
CREATE TABLE DiasSemanas(
id_dia int primary key,
dia varchar(10) not null
)
CREATE TABLE Descuentos(
id_descuento int identity primary key,
id_dia int,
hora time,
porcentaje_descuento decimal(10,2) not null,
FOREIGN KEY (id_dia) REFERENCES DiasSemanas(id_dia)
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
razon_social varchar(50) not null,
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
GO
INSERT INTO Paises (pais) VALUES ('Argentina');
INSERT INTO Paises (pais) VALUES ('Uruguay');
INSERT INTO Paises (pais) VALUES ('España');

INSERT INTO Provincias (id_pais, provincia) VALUES (1, 'Córdoba');
INSERT INTO Provincias (id_pais, provincia) VALUES (1, 'Buenos Aires');
INSERT INTO Provincias (id_pais, provincia) VALUES (1, 'Santa Fe');
INSERT INTO Provincias (id_pais, provincia) VALUES (2, 'Montevideo');
INSERT INTO Provincias (id_pais, provincia) VALUES (2, 'Canelones');
INSERT INTO Provincias (id_pais, provincia) VALUES (2, 'Maldonado');
INSERT INTO Provincias (id_pais, provincia) VALUES (3, 'Cataluña');
INSERT INTO Provincias (id_pais, provincia) VALUES (3, 'Madrid');
INSERT INTO Provincias (id_pais, provincia) VALUES (3, 'Andalucía');

INSERT INTO Localidades (id_provincia, localidad) VALUES (1, 'Córdoba');
INSERT INTO Localidades (id_provincia, localidad) VALUES (2, 'Buenos Aires');
INSERT INTO Localidades (id_provincia, localidad) VALUES (3, 'Rosario');
INSERT INTO Localidades (id_provincia, localidad) VALUES (4, 'Montevideo');
INSERT INTO Localidades (id_provincia, localidad) VALUES (5, 'Canelones');
INSERT INTO Localidades (id_provincia, localidad) VALUES (6, 'Punta del Este');
INSERT INTO Localidades (id_provincia, localidad) VALUES (7, 'Barcelona');
INSERT INTO Localidades (id_provincia, localidad) VALUES (8, 'Madrid');
INSERT INTO Localidades (id_provincia, localidad) VALUES (9, 'Sevilla');


INSERT INTO Barrios (id_localidad, barrio) VALUES (1, 'Nueva Córdoba');
INSERT INTO Barrios (id_localidad, barrio) VALUES (2, 'Palermo');
INSERT INTO Barrios (id_localidad, barrio) VALUES (4, 'Centro');
INSERT INTO Barrios (id_localidad, barrio) VALUES (5, 'Ciudad de la Costa');
INSERT INTO Barrios (id_localidad, barrio) VALUES (7, 'Eixample');
INSERT INTO Barrios (id_localidad, barrio) VALUES (8, 'Chamberí');

INSERT INTO TiposDocumentos (tipo_documento) VALUES ('DNI');
INSERT INTO TiposDocumentos (tipo_documento) VALUES ('Pasaporte');
INSERT INTO TiposDocumentos (tipo_documento) VALUES ('CI');
INSERT INTO TiposDocumentos (tipo_documento) VALUES ('NIE');


INSERT INTO Clientes (id_cliente, nombre, apellido, id_tipo_documento, documento, sexo, email, telefono) 
VALUES (1, 'Juan', 'Pérez', 1, 12345678, 'M', 'juan.perez@gmail.com', 3511234567);
INSERT INTO Clientes (id_cliente, nombre, apellido, id_tipo_documento, documento, sexo, email, telefono) 
VALUES (2, 'María', 'González', 1, 87654321, 'F', 'maria.gonzalez@gmail.com', 3517654321);
INSERT INTO Clientes (id_cliente, nombre, apellido, id_tipo_documento, documento, sexo, email, telefono) 
VALUES (3, 'Carlos', 'López', 2, 123456789, 'M', 'carlos.lopez@gmail.com', 1155555555);
INSERT INTO Clientes (id_cliente, nombre, apellido, id_tipo_documento, documento, sexo, email, telefono) 
VALUES (4, 'Ana', 'Martínez', 1, 11223344, 'F', 'ana.martinez@gmail.com', 3411234567);
INSERT INTO Clientes (id_cliente, nombre, apellido, id_tipo_documento, documento, sexo, email, telefono) 
VALUES (5, 'Luis', 'García', 1, 55667788, 'M', 'luis.garcia@gmail.com', 2212345678);
INSERT INTO Clientes (id_cliente, nombre, apellido, id_tipo_documento, documento, sexo, email, telefono) 
VALUES (6, 'Miguel', 'Hernández', 3, 99887766, 'M', 'miguel.hernandez@gmail.com', 2912345678);
INSERT INTO Clientes (id_cliente, nombre, apellido, id_tipo_documento, documento, sexo, email, telefono) 
VALUES (7, 'Laura', 'Ramírez', 3, 88776655, 'F', 'laura.ramirez@gmail.com', 2917654321);
INSERT INTO Clientes (id_cliente, nombre, apellido, id_tipo_documento, documento, sexo, email, telefono) 
VALUES (8, 'José', 'Sánchez', 4, 77665544, 'M', 'jose.sanchez@gmail.com', 931234567);
INSERT INTO Clientes (id_cliente, nombre, apellido, id_tipo_documento, documento, sexo, email, telefono) 
VALUES (9, 'Elena', 'Gómez', 4, 66554433, 'F', 'elena.gomez@gmail.com', 914567890);
INSERT INTO Clientes (id_cliente, nombre, apellido, id_tipo_documento, documento, sexo, email, telefono) 
VALUES (10, 'Sergio', 'Díaz', 1, 55443322, 'M', 'sergio.diaz@gmail.com', 955123456);

INSERT INTO Sucursales (id_sucursal, nombre, id_barrio, direccion, altura)
VALUES 
(1, 'Sucursal Centro', 1, 'Av. Libertador', 123),
(2, 'Sucursal Norte', 2, 'Calle Las Flores', 456),
(3, 'Sucursal Sur', 3, 'Boulevard San Martin', 789),
(4, 'Sucursal Oeste', 4, 'Av. 9 de Julio', 101),
(5, 'Sucursal Este', 5, 'Calle Independencia', 202);

INSERT INTO Directores (id_director, nombre, apellido) 
VALUES 
(1, 'Quentin', 'Tarantino'),
(2, 'Greta', 'Gerwig'),
(3, 'Pedro', 'Almodóvar'),
(4, 'Guillermo', 'Del Toro'),
(5, 'Ava', 'DuVernay'),
(6, 'Mike', 'Newell'),
(7, 'George', 'Lucas'),
(8, 'Gore', 'Verbinski'),
(9, 'Makoto', 'Shinkai')


INSERT INTO Categorias (categoria) 
VALUES 
('Acción'),
('Drama'),
('Comedia'),
('Documental'),
('Animación');

INSERT INTO Generos (genero) 
VALUES 
('Ciencia Ficción'),
('Romance'),
('Terror'),
('Aventura'),
('Fantasía');

INSERT INTO Idiomas (idioma) 
VALUES 
('Español'),
('Inglés'),
('Francés'),
('Alemán'),
('Japonés');

INSERT INTO Peliculas (id_pelicula, titulo, id_director, duracion, descripcion, puntuacion, id_categoria, id_genero, fecha_estreno, id_idioma) 
VALUES 
(1, 'Pulp Fiction', 1, '02:34:00', 'Un clásico del cine negro.', 9.3, 1, 1,'21-05-1994', 2),
(2,'Harry Potter y el Cáliz de Fuego', 6, '02:37:00', 'Cuarta entrega de la saga, donde Harry compite en el Torneo de los Tres Magos.', 8.5, 1, 1,'18-11-2005', 1),
(3, 'El Laberinto del Fauno', 4, '01:58:00', 'Una niña escapa a un mundo de fantasía.', 8.2, 4, 5,'11-10-2006', 1),
(4, 'Roma', 3, '02:15:00', 'La vida de una familia en los 70s.', 8.4, 4, 2,'30-08-2018', 1),
(5, 'Star Wars: El Ataque de los Clones', 7, '02:22:00', 'La segunda película de la saga precuela de Star Wars, centrada en el conflicto de las Guerras Clon.', 7.2, 2, 1,'16-05-2002', 2),
(6, 'Piratas del Caribe: El cofre de la muerte', 8, '02:31:00', 'El Capitán Jack Sparrow busca evitar su condena eterna en el Holandés Errante al encontrar el Cofre de Davy Jones.', 7.3, 1, 1,'07-07-2006', 1),
(7, 'Your Name', 9, '01:52:00', 'Una chica de campo y un chico de ciudad descubren que pueden intercambiar cuerpos a través de los sueños, lo que cambia sus vidas.', 8.4, 2, 2,'26-08-2016', 5);


INSERT INTO Funciones (id_funcion, id_sucursal, id_pelicula, fecha, horario)
VALUES 
(1, 1, 1,'15-10-2024', '14:00:00'),
(2, 2, 2,'16-10-2024', '16:30:00'),
(3, 3, 3,'17-10-2024','18:00:00'),
(4, 4, 4,'18-10-2024','20:00:00'),
(5, 5, 5,'19-10-2024','21:30:00');


INSERT INTO Empleados (id_empleado, nombre, apellido, id_tipo_documento, documento, id_sucursal)
VALUES 
(1, 'Luca', 'Casamayor', 1, 12345678, 1),
(2, 'Gino', 'Carabelli', 1, 87654321, 2),
(3, 'Gino', 'Ceccarelli', 2, 23456789, 3),
(4, 'Leo', 'Demetrio', 1, 34567890, 4),
(5, 'Mateo', 'Delgado', 2, 45678901, 5),
(6, 'Leo', 'Acosta', 2, 45678901, 1);

INSERT INTO TiposSalas (tipo_sala) 
VALUES 
('2D'),
('3D'),
('IMAX'),
('VIP'),
('4DX');

INSERT INTO Salas (id_sala, id_sucursal, capacidad, id_tipo_sala) 
VALUES 
(1, 1, 100, 1),
(2, 2, 150, 2),
(3, 3, 200, 3),
(4, 4, 80, 4),
(5, 5, 120, 5);

INSERT INTO SalasFunciones (id_sala_funcion, id_sala, id_funcion) 
VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

INSERT INTO DiasSemanas (id_dia, dia)
VALUES (1, 'Lunes'),
(2, 'Martes'),
(3, 'Miércoles'),
(4, 'Jueves'),
(5, 'Viernes'),
(6, 'Sábado'),
(7, 'Domingo');

insert into Descuentos(id_dia, porcentaje_descuento) 
values (1, 10.00),
(2, 50.00),
(3, 30.00)

insert into FormasPagos(forma_pago)
values
('Efectivo'),
('Tarjeta de Credito'),
('Tarjeta de Debito'),
('Codigo QR'),
('Transferencia')

insert into EstadosReservas(estado_reserva)
values
('Ocupado'),
('Disponible'),
('Reservado')

INSERT INTO Asientos(id_asiento, enumeracion, fila, id_sala_funcion) 
VALUES (1, 1, 'A', 1),
(2, 2, 'A', 1),
(3, 3, 'A', 1),
(4, 1, 'B', 1),
(5, 2, 'B', 1),
(6, 3, 'B', 1),
(7, 1, 'A', 2),
(8, 2, 'A', 2),
(9, 3, 'A', 2),
(10, 1, 'B', 2),
(11, 2, 'B', 2),
(12, 3, 'B', 2),
(13, 1, 'A', 3),
(14, 2, 'A', 3),
(15, 3, 'A', 3),
(16, 1, 'B', 3),
(17, 2, 'B', 3),
(18, 3, 'B', 3),
(19, 1, 'A', 4),
(20, 2, 'A', 4),
(21, 3, 'A', 4),
(22, 1, 'B', 4),
(23, 2, 'B', 4),
(24, 3, 'B', 4),
(25, 1, 'A', 5),
(26, 2, 'A', 5),
(27, 3, 'A', 5),
(28, 1, 'B', 5),
(29, 2, 'B', 5),
(30, 3, 'B', 5)

insert into Reservas(id_reserva,id_estado_reserva, hora_reserva, id_sala_funcion, id_asiento)
values
(1,1,'21:00:00',1,1),
(2,2,'22:00:00',2,2),
(3,2,'20:30:00',3,3),
(4,3,'21:30:00',4,4),
(5,3,'19:45:00',5,5)

insert into Facturas(id_factura, id_reserva, id_cliente, id_empleado, razon_social, id_forma_pago)
values
(1,1,1,1,'Cine Entertainment',1),
(2,2,3,3,'Cine Entertainment',2),
(3,3,2,3,'Cine Entertainment',2),
(4,4,5,5,'Cine Entertainment',4),
(5,5,4,1,'Cine Entertainment',3)

insert into Tickets(id_ticket, id_factura, id_sala_funcion, id_asiento,id_descuento, pre_unitario)
values
(1,1,1,1,1,5000.00),
(2,2,3,3,3,5000.00),
(3,3,4,2,2,5000.00),
(4,4,5,5,3,5000.00),
(5,5,2,4,1,5000.00)

--1 Películas con puntuación superior a 8, agrupadas por género y ordenadas por puntuación promedio:
SELECT g.genero, p.puntuacion AS puntuacion_promedio
FROM Peliculas p
JOIN Generos g ON p.id_genero = g.id_genero
WHERE p.puntuacion > 8
ORDER BY puntuacion_promedio DESC

--2 Mostrar el nombre y apellido de los clientes que cuenten con menos de 5 reservas 
SELECT c.nombre, c.apellido, COUNT(r.id_reserva) reservas
FROM Clientes c
JOIN Facturas f ON c.id_cliente = f.id_cliente
JOIN Reservas r ON f.id_reserva = r.id_reserva
GROUP BY c.id_cliente, c.nombre, c.apellido
HAVING COUNT(r.id_reserva) < 5

--3 Calcular el ingreso total por sucursal, considerando el precio unitario de los tickets y aplicando cualquier descuento.
SELECT Sucursales.nombre AS Sucursal, 
       SUM(Tickets.pre_unitario * (1 - ISNULL(Descuentos.porcentaje_descuento, 0) / 100)) AS IngresoTotal
FROM Tickets
JOIN Facturas ON Tickets.id_factura = Facturas.id_factura
JOIN Reservas ON Facturas.id_reserva = Reservas.id_reserva
JOIN SalasFunciones ON Reservas.id_sala_funcion = SalasFunciones.id_sala_funcion
JOIN Salas ON SalasFunciones.id_sala = Salas.id_sala
JOIN Sucursales ON Salas.id_sucursal = Sucursales.id_sucursal
LEFT JOIN Descuentos ON Tickets.id_descuento = Descuentos.id_descuento
GROUP BY Sucursales.nombre
ORDER BY IngresoTotal DESC

--4 Crear una vista que muestre los detalles de las funciones (película, sucursal, horario) y la disponibilidad de asientos.
CREATE VIEW VistaFunciones AS
SELECT Peliculas.titulo AS Pelicula, 
       Sucursales.nombre AS Sucursal, 
       Funciones.fecha, 
       Funciones.horario, 
       (SELECT COUNT(*) FROM Asientos WHERE Asientos.id_sala_funcion = SalasFunciones.id_sala_funcion) AS AsientosDisponibles
FROM Funciones
JOIN Peliculas ON Funciones.id_pelicula = Peliculas.id_pelicula
JOIN SalasFunciones ON Funciones.id_funcion = SalasFunciones.id_funcion
JOIN Salas ON SalasFunciones.id_sala = Salas.id_sala
JOIN Sucursales ON Salas.id_sucursal = Sucursales.id_sucursal

--5 Listar las películas cuya puntuación es mayor al promedio de las puntuaciones de todas las películas del mismo género.
SELECT Peliculas.titulo, 
       Peliculas.puntuacion, 
       Generos.genero
FROM Peliculas
JOIN Generos ON Peliculas.id_genero = Generos.id_genero
WHERE Peliculas.puntuacion > (SELECT AVG(puntuacion)
							  FROM Peliculas
							  WHERE Peliculas.id_genero = Generos.id_genero)

--6 Se necesita mostrar nombre, apellido y asiento de los clientes que hayan hecho una reserva para un día de descuento
SELECT c.id_cliente, c.nombre + ' ' + c.apellido Cliente, STR(a.enumeracion) + fila Asiento, STR(d.porcentaje_descuento) + '%' Descuento, COUNT(r.id_reserva) Reservas
FROM Facturas f
JOIN Clientes c ON c.id_cliente = f.id_factura
JOIN Reservas r ON r.id_reserva = f.id_reserva
JOIN Asientos a ON a.id_asiento = r.id_asiento
JOIN Tickets t ON t.id_asiento = r.id_asiento
JOIN Descuentos d ON d.id_descuento = t.id_descuento
JOIN DiasSemanas ds ON d.id_dia = ds.id_dia
JOIN SalasFunciones sf ON sf.id_sala_funcion = r.id_sala_funcion
JOIN Funciones fu ON fu.id_funcion = sf.id_funcion
WHERE DATEPART(WEEKDAY, fu.fecha) IN (1,2,3)
GROUP BY c.id_cliente, c.nombre, c.apellido, a.enumeracion, a.fila, d.porcentaje_descuento

--7 Calcular el total de ingresos generados por cada película en función de la suma de los precios de los tickets vendidos 
-- incluidas aquellas que recaudaron $0
SELECT Peliculas.titulo, 
       COALESCE(SUM(Tickets.pre_unitario), 0) AS TotalIngresos
FROM Peliculas
LEFT JOIN Funciones ON Peliculas.id_pelicula = Funciones.id_pelicula
LEFT JOIN SalasFunciones ON Funciones.id_funcion = SalasFunciones.id_funcion
LEFT JOIN Tickets ON SalasFunciones.id_sala_funcion = Tickets.id_sala_funcion
GROUP BY Peliculas.titulo
ORDER BY TotalIngresos DESC

--8 Mostrar los directores cuyas peliculas tengan una puntuación mayor a 9
SELECT 
d.id_director,
d.nombre + ' ' + d.apellido AS director_nombre,
COUNT(p.id_pelicula) AS cantidad_peliculas,
AVG(p.puntuacion) AS puntuacion_promedio
FROM Directores d
JOIN Peliculas p ON d.id_director = p.id_director
GROUP BY d.id_director, d.nombre, d.apellido
HAVING AVG(p.puntuacion) > 9
ORDER BY puntuacion_promedio DESC, cantidad_peliculas DESC;

