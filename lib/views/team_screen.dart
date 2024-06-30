// team_screen.dart
import 'package:flutter/material.dart';
import 'team_controller.dart';
import 'pokemon_details_screen.dart';

class TeamScreen extends StatefulWidget {
  final TeamController controller;

  TeamScreen({required this.controller});

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Equipo'),
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: widget.controller.getTeam(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final pokemon = snapshot.data![index];
                return ListTile(
                  leading: Image.network(pokemon.sprites.frontDefault),
                  title: Text(pokemon.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PokemonDetailsScreen(pokemon: pokemon)),
                    );
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Cambiar nombre'),
                          content: TextField(
                            onChanged: (value) {
                              widget.controller.updatePokemonName(pokemon, value);
                            },
                          ),
                          actions: [
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}