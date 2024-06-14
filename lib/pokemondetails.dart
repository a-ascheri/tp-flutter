import 'package:flutter/material.dart';

class PokemonDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> pokemon;

  PokemonDetailsScreen({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon['name']),
      ),
      body: Center(
        child: Text('Details for ${pokemon['name']}'),
      ),
    );
  }
}