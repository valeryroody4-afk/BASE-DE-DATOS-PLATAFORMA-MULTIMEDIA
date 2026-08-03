--- BASE DE DATOS PLATAFORMA MULTIMEDIA

--- DDL -> Lenguaje de Definición de Datos
--- Crea la estructura de la base de datos.

--- DML -> Lenguaje de Manipulación de Datos
--- Permite insertar, actualizar, eliminar y consultar información.

--- Creación de la base de datos plataforma_multimedia
CREATE DATABASE plataforma_multimedia;

USE plataforma_multimedia;

--- tabla usuario
CREATE TABLE usuario(
    nombre_usuario INT (10) PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    fecha_registro DATETIME NOT NULL
);

--- tabla plan

CREATE TABLE plan(
    num_plan INT (5) PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL UNIQUE,
    precio DECIMAL(10,2) NOT NULL,
    beneficio VARCHAR(255) NOT NULL
);

--- tabla artista

CREATE TABLE artista(
    num_artista INT(10) PRIMARY KEY AUTO_INCREMENT,
    nombre_artistico VARCHAR(100) NOT NULL,
    rfc VARCHAR(13) NOT NULL,
    cuentaBancaria VARCHAR (20) NOT NULL 
);

--- tabla estudio

CREATE TABLE estudio(
    num_estudio INT(10) PRIMARY KEY AUTO_INCREMENT,
    nombre_empresa VARCHAR (100) NOT NULL UNIQUE, 
    rfc_empresa VARCHAR(12) NOT NULL UNIQUE,
    nombre_pila VARCHAR (30) NOT NULL,
    primer_apellido VARCHAR(30) NOT NULL,
    segundo_apellido VARCHAR (30) NULL,
    telefono VARCHAR(15) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_final DATE NOT NULL
);

--- tabla genero

CREATE TABLE genero(
    num_genero INT (5) PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR (50) NOT NULL UNIQUE,
    descripcion VARCHAR(25) NOT NULL

);

--- tabla terminos_lic
CREATE TABLE terminos_lic(
    codigo_termino VARCHAR (5) PRIMARY KEY AUTO_INCREMENT, #Se quita el auto incrementable#
    nombre VARCHAR(100) NOT NULL UNIQUE,
    tipo_terminos VARCHAR (50) NOT NULL,
    restricciones VARCHAR (255) NOT NULL,
    descripcion VARCHAR (255) NOT NULL
);

--- tabla playlist
CREATE TABLE playlist(
    num_playlist INT (10) PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR (100) NOT NULL,
    total_elementos INT (10) NOT NULL DEFAULT (0),
    fecha_creacion  DATE NOT NULL,
    usuario INT (10) NOT NULL,
    FOREING KEY (usuario) REFERENCES usuario (num)
);

--- tabla album
CREATE TABLE album(
    num_album INT(10) PRIMARY KEY AUTO_INCREMENT,
    titulo_portada VARCHAR (100) NOT NULL,
    artista INT (10) NOT NULL,
    FOREING KEY (artista) REFERENCES artista(num)
);

--- tabla pist
CREATE TABLE pista(
    num_pista INT(10) PRIMARY KEY AUTO_INCREMENT,
    titulo_ portada  varchar (100) NOT NULL,
    duracion TIME NOT NULL,
    archivo_audio_url VARCHAR (255) NOT NULL,
    fecha_publicidad DATE NOT NULL,
    genero INT (5) NOT NULL,
    FOREIGN KEY (genero) REFERENCES genero(num)
);

--- tabla suscripcion
CREATE TABLE suscripcion(
    num_suscripcion INT (10) PRIMARY KEY AUTO_INCREMENT,
    terminos VARCHAR (255) NOT NULL,
    estado VARCHAR (20) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_final DATE NOT NULL
    usuario INT (10) NOT NULL, 
    plan INT(5) NOT NULL,
    FOREIGN  KEY (usuariio) REFERENCES usuario (num),
    FOREIGN KEY (plan) REFERENCES plan (num)
);

-- tabla pago
CREATE TABLE pago(
    codigo VARCHAR (11) PRIMARY KEY,
    fecha_pago DATE NOT NULL,
    monto DECIMAL(8,2) NOT NULL,
     
)



