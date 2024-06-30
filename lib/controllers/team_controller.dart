// team_controller.dart
import '../models/pokemon.dart';
import '../services/team_service.dart';

class TeamController {
  final TeamService service;

  TeamController({required this.service});

  Future<List<Pokemon>> getTeam() async {
    try {
      final equipo = await service.getPokemonTeam(1); // Asume que el ID del usuario es 1
      return equipo;
    }
    catch(error) {
      return [];
    }
  }

  void updatePokemonName(Pokemon pokemon, String newName) {
    pokemon.name = newName;
    service.updatePokemon(pokemon);
  }
}