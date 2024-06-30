import '../services/pokemon_service.dart';
import '../services/team_service.dart';
import '../models/pokemon.dart';

class PokedexController {
  final PokemonService pokemonService;
  final TeamService teamService;

  PokedexController({required this.pokemonService, required this.teamService});

  Future<List<Pokemon>> getPokemons() {
    return pokemonService.fetchPokemons();
  }

  List<Pokemon> filterPokemonByType(List<Pokemon> pokemonList, String type) {
    if (type == 'all') {
      return pokemonList;
    }

    List<Pokemon> tempFilteredList = pokemonList
      .where((pokemon) => pokemon.types.contains(type))
      .toList();

    tempFilteredList.sort((a, b) => a.id.compareTo(b.id));
    
    return tempFilteredList;
  }

  Future<void> addPokemonToTeam(Pokemon pokemon) {
    return teamService.addPokemonToTeam(pokemon);
  }
}