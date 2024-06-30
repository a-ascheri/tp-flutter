import 'package:prueba/models/pokemon.dart';
import 'package:prueba/services/database_service.dart';

class TeamService {
  final DatabaseService _dbService = DatabaseService();

  Future<List<Pokemon>> getPokemonTeam() async {
    final db = await _dbService.database;
    final results = await db.query('pokemon');

    return results.map((row) => Pokemon.fromMap(row)).toList();
  }

  Future<void> addPokemonToTeam(Pokemon pokemon) async {
    final db = await _dbService.database;
    await db.insert('pokemon', pokemon.toMap());
  }

  Future<void> removePokemonFromTeam(Pokemon pokemon) async {
    final db = await _dbService.database;
    await db.delete('pokemon', where: 'id = ?', whereArgs: [pokemon.id]);
  }

  Future<void> updatePokemon(Pokemon pokemon) async {
    final db = await _dbService.database;
    await db.update('pokemon', pokemon.toMap(), where: 'id = ?', whereArgs: [pokemon.id]);
  }
}