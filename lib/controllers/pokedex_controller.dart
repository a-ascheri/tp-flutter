import 'pokemon_service.dart';
import 'pokemon.dart';

class PokedexController {
  final PokemonService pokemonService;

  PokedexController({required this.pokemonService});

  Future<List<Pokemon>> getPokemon() {
    return pokemonService.fetchPokemon();
  }
}