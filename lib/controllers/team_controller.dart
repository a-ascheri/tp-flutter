// team_controller.dart
import 'team_service.dart';
import 'pokemon.dart';

class TeamController {
  final TeamService service;

  TeamController({required this.service});

  Future<List<Pokemon>> getTeam() async {
    final equipo = await service.getTeam(1); // Asume que el ID del usuario es 1
    return equipo.pokemones;
  }

  void updatePokemonName(Pokemon pokemon, String newName) {
    pokemon.name = newName;
    service.updatePokemon(pokemon);
  }
}