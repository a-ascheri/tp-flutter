// team_screen.dart
import 'package:flutter/material.dart';
import 'package:prueba/models/pokemon.dart';
import 'package:prueba/services/team_service.dart';

import '../controllers/team_controller.dart';
import '../views/pokemondetails.dart';

class TeamScreen extends StatefulWidget {
  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  final TeamController controller = TeamController(service: TeamService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Equipo'),
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: controller.getTeam(),
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
                  leading: Image.network(pokemon.imageUrl),
                  title: Text(pokemon.name),
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
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Cambiar nombre'),
                          content: TextField(
                            onChanged: (value) {
                              controller.updatePokemonName(pokemon, value);
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