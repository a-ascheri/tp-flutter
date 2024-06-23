import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pokemon.dart';

class PokedexController {
  Future<List<Pokemon>> fetchPokemonData() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=400'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Pokemon> pokemonList = [];
      for (int i = 0; i < data['results'].length; i++) {
        final pokemon = Pokemon.fromJson(data['results'][i], i + 1);
        await pokemon.fetchDetails();
        pokemonList.add(pokemon);
      }
      return pokemonList;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  List<Pokemon> filterPokemonByType(List<Pokemon> pokemonList, String type) {
    if (type == 'all') {
      return pokemonList;
    }
    return pokemonList.where((pokemon) => pokemon.types.contains(type)).toList();
  }
  List<Pokemon> limitPokemonQuantity(List<Pokemon> pokemonList, int quantity) {
    return pokemonList.take(quantity).toList();
  }
}
