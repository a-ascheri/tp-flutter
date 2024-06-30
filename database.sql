-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS pokemon_app;

-- Usar la base de datos
USE pokemon_app;

CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL
);

-- Crear la tabla pokemon
CREATE TABLE pokemon (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    imageUrl VARCHAR(255),
    types VARCHAR(255),
    usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

-- Insertar un usuario
INSERT INTO usuario (usuario, contrasena) VALUES ('user1', 'password1');

-- Insertar cuatro Pokémon
INSERT INTO pokemon (usuario_id, name, types, imageUrl, usuario_id)
VALUES 
    (1, 'Pikachu', 'Pikachu', 'Electric', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png', 25),
    (1, 'Charizard', 'Charizard', 'Fire, Flying', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/6.png', 6),
    (1, 'Blastoise', 'Blastoise', 'Water', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/9.png', 9),
    (1, 'Venusaur', 'Venusaur', 'Grass, Poison', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/3.png', 3);