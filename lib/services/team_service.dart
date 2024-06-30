// team_service.dart
import 'package:prueba/models/pokemon.dart';
import 'package:prueba/services/database_service.dart';

class TeamService {
  final DatabaseService _dbService = DatabaseService();

  Future<List<Pokemon>> getPokemonTeam(int userId) async {
    final db = await _dbService.connection;
    final results = await db.query('SELECT * FROM pokemon WHERE user_id = ?', [userId]);

    return results.map((row) => Pokemon.fromMap(row.fields)).toList();
  }

  Future<void> addPokemonToTeam(Pokemon pokemon) async {
    final db = await _dbService.connection;
    await db.query('INSERT INTO pokemon (usuario_id, name, id, imageUrl, types) VALUES (1, ?, ?, ?, ?)', [
      pokemon.name,
      pokemon.id,
      pokemon.imageUrl,
      pokemon.types.join(', '),
    ]);
  }

  Future<void> removePokemonFromTeam(Pokemon pokemon) async {
    final db = await _dbService.connection;
    await db.query('DELETE FROM pokemon WHERE id = ? and usuario_id=1', [pokemon.id]);
  }

  Future<void> updatePokemon(Pokemon pokemon) async {
    final db = await _dbService.connection;
    await db.query('UPDATE pokemon SET name = ? WHERE id = ?', [pokemon.name, pokemon.id]);
  }
}