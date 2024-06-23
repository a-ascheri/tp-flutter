import 'package:flutter/material.dart';

import 'views/pokedex.dart';
import 'views/pokemondetails.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      initialRoute: "/",
      routes: {
        "/": (context) => PokedexScreen(),
        "pokemondetails": (context) => PokemonDetailsScreen(pokemon: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
