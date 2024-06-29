-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS pokemon_app;

-- Usar la base de datos
USE pokemon_app;

-- Crear la tabla usuario
CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL
);

-- Crear la tabla equipo
CREATE TABLE equipo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    mote VARCHAR(50),
    nombre VARCHAR(50) NOT NULL,
    tipos VARCHAR(100) NOT NULL,
    foto VARCHAR(255),
    pokemon_id INT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    UNIQUE KEY usuario_pokemon_unique (usuario_id, pokemon_id)
);
