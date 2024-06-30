import 'package:flutter/material.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'team_service.dart';

Future<QueryExecutor> _openConnection() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(p.join(dbFolder.path, 'db.sqlite'));
  return VmDatabase(file);
}

void main() async {
  final executor = await _openConnection();
  final teamService = TeamService(executor);
  runApp(MyApp(teamService: teamService));
}

class MyApp extends StatelessWidget {
  final TeamService teamService;

  const MyApp({required this.teamService, Key? key}) : super(key: key);

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
