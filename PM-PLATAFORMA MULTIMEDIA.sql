-- Active: 1785756641768@@127.0.0.1@3306@plataforma_multimedia
--- BASE DE DATOS PLATAFORMA MULTIMEDIA

--- DDL -> Lenguaje de Definición de Datos
--- Crea la estructura de la base de datos.

--- DML -> Lenguaje de Manipulación de Datos
--- Permite insertar, actualizar, eliminar y consultar información.

--- Creación de la base de datos plataforma_multimedia
CREATE DATABASE plataforma_multimedia;

USE plataforma_multimedia;

-- DROP TABLE IF EXISTS usuario; <---- # Esta existe para borrar un tabla existente 

##############################################################
--    1. Tablas independientes (no dependen de ninguna)    --
##############################################################

--- tabla usuario

-- TABLA: USUARIO

CREATE TABLE usuario(
    num_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    fecha_registro DATETIME NOT NULL
);

-- TABLA: PLAN

CREATE TABLE plan(
    codigo_plan VARCHAR(6) PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL UNIQUE,
    precio DECIMAL(10,2) NOT NULL,
    beneficio VARCHAR(255) NOT NULL
);

-- TABLA: ARTISTA

CREATE TABLE artista(
    codigo_artista VARCHAR(6) PRIMARY KEY,
    nombre_artistico VARCHAR(100) NOT NULL,
    rfc VARCHAR(13) NOT NULL UNIQUE,
    cuenta_bancaria VARCHAR(20) NOT NULL
);

-- TABLA: ESTUDIO

CREATE TABLE estudio(
    codigo_estudio VARCHAR(6) PRIMARY KEY,
    nombre_empresa VARCHAR(100) NOT NULL UNIQUE,
    rfc_empresa VARCHAR(12) NOT NULL UNIQUE,
    nombre_pila VARCHAR(30) NOT NULL,
    primer_apellido VARCHAR(30) NOT NULL,
    segundo_apellido VARCHAR(30),
    telefono VARCHAR(15) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_final DATE NOT NULL
);

-- TABLA: GÉNERO

CREATE TABLE genero(
    codigo_genero VARCHAR(6) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255) NOT NULL
);


-- TABLA: TERMINOS_LIC

CREATE TABLE terminos_lic(
    codigo_termino VARCHAR(6) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    tipo_terminos VARCHAR(50) NOT NULL,
    restricciones VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255) NOT NULL
);
###############################################
--      2. Tablas que son relacionadas      --
###############################################
-- TABLA: PLAYLIST

CREATE TABLE playlist(
    num_playlist INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    total_elementos INT NOT NULL DEFAULT 0,
    fecha_creacion DATETIME NOT NULL,
    usuario INT NOT NULL,
    FOREIGN KEY (usuario) REFERENCES usuario(num_usuario)
);

-- TABLA: ALBUM

CREATE TABLE album(
    codigo_album VARCHAR(6) PRIMARY KEY,
    titulo_portada VARCHAR(100) NOT NULL,
    artista VARCHAR(6) NOT NULL,
    FOREIGN KEY (artista) REFERENCES artista( codigo_artista)
);


-- TABLA: PISTA

CREATE TABLE pista(
    codigo_pista VARCHAR(6) PRIMARY KEY,
    titulo_portada VARCHAR(100) NOT NULL,
    duracion TIME NOT NULL,
    archivo_audio_url VARCHAR(255) NOT NULL,
    fecha_publicado DATE NOT NULL,
    genero VARCHAR(6) NOT NULL,
    FOREIGN KEY (genero) REFERENCES genero(codigo_genero)
);

-- TABLA: SUSCRIPCION

CREATE TABLE suscripcion(
    num_suscripcion INT PRIMARY KEY AUTO_INCREMENT,
    terminos VARCHAR(255) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_final DATE NOT NULL,
    usuario INT NOT NULL,
    plan VARCHAR(6) NOT NULL,

    FOREIGN KEY (usuario) REFERENCES usuario(num_usuario),
    FOREIGN KEY (plan) REFERENCES plan(codigo_plan)
);

-- TABLA: PAGO

CREATE TABLE pago(
    codigo_pago VARCHAR(6) PRIMARY KEY,
    fecha_pago DATETIME NOT NULL,
    monto DECIMAL(8,2) NOT NULL,
    metodo_pago VARCHAR(30) NOT NULL,
    estado_pago VARCHAR(20) NOT NULL,
    referencia_pago VARCHAR(50) NOT NULL UNIQUE,
    suscripcion INT NOT NULL,

    FOREIGN KEY (suscripcion)
    REFERENCES suscripcion(num_suscripcion)
);

-- TABLA: LICENCIA

CREATE TABLE licencia(
    codigo_licencia VARCHAR(6) PRIMARY KEY,
    costo DECIMAL(10,2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_final DATE,
    termino VARCHAR(6) NOT NULL,
    pista VARCHAR(6) NOT NULL,

    FOREIGN KEY (termino)
    REFERENCES terminos_lic(codigo_termino),

    FOREIGN KEY (pista)
    REFERENCES pista(codigo_pista)
);

-- TABLA: CONTRATO

CREATE TABLE contrato(
    codigo_contrato VARCHAR(6) PRIMARY KEY,
    terminos VARCHAR(255) NOT NULL,
    porcen_regalias DECIMAL(5,2) NOT NULL,
    fecha_firma DATE NOT NULL,
    artista VARCHAR(6) NOT NULL,
    licencia VARCHAR(6) NOT NULL,
    estudio VARCHAR(6) NOT NULL,

    FOREIGN KEY (artista)
    REFERENCES artista(codigo_artista),

    FOREIGN KEY (licencia)
    REFERENCES licencia(codigo_licencia),

    FOREIGN KEY (estudio)
    REFERENCES estudio(codigo_estudio)
);

-- TABLA: INTERACCION

CREATE TABLE interaccion(
    num_interaccion INT PRIMARY KEY AUTO_INCREMENT,
    tipo_interaccion VARCHAR(20) NOT NULL,
    comentario VARCHAR(255),
    fecha DATETIME NOT NULL,
    usuario INT NOT NULL,
    pista VARCHAR(6) NOT NULL,

    FOREIGN KEY (usuario)
    REFERENCES usuario(num_usuario),

    FOREIGN KEY (pista)
    REFERENCES pista(codigo_pista)
);


#################################################
--   3. Tablas que son relacionadas en (M:M)   --
#################################################

-- TABLA: PLAYLIST_PISTA

CREATE TABLE playlist_pista(
    num_playlist INT,
    codigo_pista VARCHAR(6),

    FOREIGN KEY (num_playlist)
    REFERENCES playlist(num_playlist),

    FOREIGN KEY (codigo_pista)
    REFERENCES pista(codigo_pista),

    PRIMARY KEY (num_playlist, codigo_pista)
);

-- TABLA: INTERPRETA

CREATE TABLE interpreta(
    codigo_artista VARCHAR(6),
    codigo_pista VARCHAR(6),

    FOREIGN KEY (codigo_artista)
    REFERENCES artista(codigo_artista),

    FOREIGN KEY (codigo_pista)
    REFERENCES pista(codigo_pista),

    PRIMARY KEY (codigo_artista, codigo_pista)
);

-- TABLA: REPERTORIO

CREATE TABLE repertorio(
    codigo_pista VARCHAR(6),
    codigo_album VARCHAR(6),

    FOREIGN KEY (codigo_pista)
    REFERENCES pista(codigo_pista),

    FOREIGN KEY (codigo_album)
    REFERENCES album(codigo_album),

    PRIMARY KEY (codigo_pista, codigo_album)
);

-- TABLA: AUTORIZACION

CREATE TABLE autorizacion(
    codigo_plan VARCHAR(6),
    codigo_pista VARCHAR(6),

    FOREIGN KEY (codigo_plan)
    REFERENCES plan(codigo_plan),

    FOREIGN KEY (codigo_pista)
    REFERENCES pista(codigo_pista),

    PRIMARY KEY (codigo_plan, codigo_pista)
);


/*******************************
-- CONSULTAS 