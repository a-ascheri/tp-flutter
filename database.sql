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

-- Insertar un usuario
INSERT INTO usuario (usuario, contraseña)
VALUES ('user', 'pass');

-- Insertar cuatro Pokémon
INSERT INTO equipo (usuario_id, mote, nombre, tipos, foto, pokemon_id)
VALUES 
    (1, 'Pikachu', 'Pikachu', 'Electric', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png', 25),
    (1, 'Charizard', 'Charizard', 'Fire, Flying', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/6.png', 6),
    (1, 'Blastoise', 'Blastoise', 'Water', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/9.png', 9),
    (1, 'Venusaur', 'Venusaur', 'Grass, Poison', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/3.png', 3);