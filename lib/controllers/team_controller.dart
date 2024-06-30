// team_controller.dart
import '../models/pokemon.dart';
import '../services/team_service.dart';

class TeamController {
  final TeamService service;

  TeamController({required this.service});

  Future<List<Pokemon>> getTeam() async {
    return await service.getPokemonTeam();
  }

  Future<void> updatePokemonName(Pokemon pokemon, String newName) async {
    pokemon.name = newName;
    await service.updatePokemon(pokemon);
  }

  Future<void> removePokemonFromTeam(Pokemon pokemon) async {
    await service.removePokemonFromTeam(pokemon);
  }
}
