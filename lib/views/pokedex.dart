import 'package:flutter/material.dart';
import 'package:prueba/services/pokemon_service.dart';

import '../controllers/pokedex_controller.dart';
import '../models/pokemon.dart';
import 'pokemondetails.dart';

class PokedexScreen extends StatefulWidget {
  @override
  _PokedexScreenState createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  List<Pokemon> allPokemonList = [];
  List<Pokemon> filteredPokemonList = [];
  final PokedexController _controller = PokedexController(pokemonService: PokemonService());

  String selectedType = 'all';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPokemonData();
  }

  Future<void> fetchPokemonData() async {
    try {
      final List<Pokemon> fetchedPokemonList = await _controller.getPokemons();
      setState(() {
        allPokemonList = fetchedPokemonList;
        _filterPokemon();
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterPokemon() {
    List<Pokemon> tempFilteredList = _controller.filterPokemonByType(allPokemonList, selectedType);

    setState(() {
      filteredPokemonList = tempFilteredList;
    });
  }

  void _removePokemon(int index) {
    setState(() {
      filteredPokemonList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> types = [
      'All', 'Normal', 'Fighting', 'Flying', 'Poison', 'Ground', 'Rock', 'Bug', 'Ghost', 'Steel', 'Fire', 'Water', 'Grass', 'Electric', 'Psychic', 'Ice', 'Dragon', 'Dark', 'Fairy', 'Unknown', 'Shadow'
    ];

    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 184, 11, 11),
                  Color.fromRGBO(255, 20, 16, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  titleSpacing: 10,
                  centerTitle: false,
                ),
                Container(
                  height: 2.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 123, 123, 123),
                        Colors.black,
                        Color.fromARGB(255, 123, 123, 123),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  color: Colors.grey[200], // Fondo gris claro
                  child: Row(
                    children: [
                      SizedBox(width: 0.0), // Espacio a la izquierda para alinear con el borde
                      Text(
                        'Type:', // Texto "Type"
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 20.0), // Espacio entre el texto y el dropdown
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedType,
                          onChanged: (value) {
                            setState(() {
                              selectedType = value!;
                              _filterPokemon();
                            });
                          },
                          items: types.map<DropdownMenuItem<String>>((String type) {
                            return DropdownMenuItem<String>(
                              value: type.toLowerCase(),
                              child: Text(type),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1.0,
            color: Colors.black, // Línea negra separadora
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: filteredPokemonList.length,
                    itemBuilder: (context, index) {
                      final pokemon = filteredPokemonList[index];
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PokemonDetailsScreen(pokemon: {
                                    'id': pokemon.id,
                                    'name': pokemon.name,
                                    'types': pokemon.types,
                                    // Agrega más propiedades según sea necesario
                                  }),
                                ),
                              );
                            },
                            child: Dismissible(
                              key: Key(pokemon.name),
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
                                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon.id}.png',
                                  ),
                                ),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        pokemon.name.substring(0, 1).toUpperCase() + pokemon.name.substring(1),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Image.asset(
                                      'pokeball.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  pokemon.types
                                      .map((type) => type.substring(0, 1).toUpperCase() + type.substring(1))
                                      .join(', '),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              height: 0.5,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.grey.withOpacity(0.5),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
