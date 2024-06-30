import 'package:flutter/material.dart';
import 'package:prueba/views/pokedex.dart';
import 'package:prueba/views/pokemondetails.dart';
import 'package:prueba/views/team_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      initialRoute: "/",
      routes: {
        "/": (context) => PokedexScreen(),
        "/team": (context) => TeamScreen(),
        "pokemondetails": (context) => PokemonDetailsScreen(pokemon: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
