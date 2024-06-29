import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pokemon.dart';

class PokemonService {
  Future<List<Pokemon>> fetchPokemon() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=400'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Pokemon> pokemonList = [];
      for (int i = 0; i < data['results'].length; i++) {
        final pokemonData = data['results'][i];
        final pokemon = Pokemon.fromJson(pokemonData, i + 1);
        final details = await fetchPokemonDetails(pokemonData['url']);
        pokemon.types = details['types'].map<String>((typeData) => typeData['type']['name']).toList();
        pokemonList.add(pokemon);
      }
      return pokemonList;
    } else {
      throw Exception('Failed to fetch data');
    }
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