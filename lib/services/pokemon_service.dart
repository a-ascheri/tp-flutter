// pokemon_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonService {
  Future<List<Pokemon>> fetchPokemons() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=100'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Future<Pokemon>> pokemonFutures = [];
      for (int i = 0; i < data['results'].length; i++) {
        final pokemonData = data['results'][i];
        pokemonFutures.add(_createPokemon(pokemonData, i + 1));
      }
      return await Future.wait(pokemonFutures);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<Pokemon> _createPokemon(Map<String, dynamic> pokemonData, int id) async {
    final details = await fetchPokemonDetails(pokemonData['url']);
    final types = (details['types'] as List)
        .map((type) => type['type']['name'] as String)
        .toList();
    return Pokemon(
      name: pokemonData['name'],
      id: id,
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
      types: types,
    );
  }

  Future<Map<String, dynamic>> fetchPokemonDetails(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch Pokemon details');
    }
  }
}