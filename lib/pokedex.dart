import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:enclase4/pokemondetails.dart';
import 'package:http/http.dart' as http;

class PokedexScreen extends StatefulWidget {
  @override
  _PokedexScreenState createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  List<dynamic> pokemonList = [];

  @override
  void initState() {
    super.initState();
    fetchPokemonData();
  }

  Future<void> fetchPokemonData() async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        pokemonList = data['results'];
        for (int i = 0; i < pokemonList.length; i++) {
          pokemonList[i]['id'] = i + 1;
        }
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  void _removePokemon(int index) {
    setState(() {
      pokemonList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
      ),
      body: ListView.builder(
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          final pokemon = pokemonList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokemonDetailsScreen(pokemon: pokemon),
                ),
              );
            },
            child: Dismissible(
              key: Key(pokemon['name']),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                _removePokemon(index);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon['id']}.png'),
                ),
                title: Text(pokemon['name']),
                subtitle: FutureBuilder(
                  future: http.get(Uri.parse(pokemon['url'])),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('Loading...');
                    }
                    if (snapshot.hasError) {
                      return Text('Error');
                    }
                    final pokemonData = jsonDecode(snapshot.data!.body);
                    final types = pokemonData['types'];
                    final typeNames =
                        types.map((type) => type['type']['name']).toList();
                    return Text(typeNames.join(', '));
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PokedexScreen(),
  ));
}
