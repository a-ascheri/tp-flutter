import 'package:moor/moor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'team_service.g.dart';

class Usuarios extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get usuario => text().withLength(min: 1, max: 50)().customConstraint('UNIQUE')();
  TextColumn get contrasena => text().withLength(min: 1, max: 255)();
}

class Equipos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get usuarioId => integer().customConstraint('NULL REFERENCES usuarios(id)')();
  TextColumn get mote => text().nullable()();
  TextColumn get nombre => text().withLength(min: 1, max: 50)();
  TextColumn get tipos => text().withLength(min: 1, max: 100)();
  TextColumn get foto => text().nullable()();
  IntColumn get pokemonId => integer()();
}

@UseMoor(tables: [Usuarios, Equipos])
class TeamService extends _$TeamService {
  TeamService(QueryExecutor e) : super(e);

  Future<void> addPokemon(int pokemonId) async {
    final usuario = await (select(usuarios)..where((u) => u.id.equals(1))).getSingle();

    if (usuario == null) {
      throw Exception("Usuario no encontrado");
    }

    final equipos = await (select(equipos)..where((e) => e.usuarioId.equals(usuario.id))).get();

    if (equipos.length >= 6) {
      throw Exception("No puedes tener más de 6 pokemones en tu equipo");
    }

    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonId'));

    if (response.statusCode == 200) {
      final pokemon = Pokemon.fromJson(jsonDecode(response.body), pokemonId);
      await into(equipos).insert(EquiposCompanion(
        usuarioId: Value(usuario.id),
        mote: Value(pokemon.name),
        nombre: Value(pokemon.name),
        tipos: Value(pokemon.types.join(', ')),
        foto: Value(pokemon.sprites.frontDefault),
        pokemonId: Value(pokemonId),
      ));
    } else {
      throw Exception('Failed to load Pokemon');
    }
  }

  Future<void> updatePokemon(Pokemon pokemon) async {
    return transaction(() async {
      final equipoRow = await (select(equipos)..where((e) => e.pokemonId.equals(pokemon.id))).getSingle();

      if (equipoRow == null) {
        throw Exception("Pokemon no encontrado en el equipo");
      }

      await update(equipos).replace(equipoRow.copyWith(mote: pokemon.name));
    });
  }

  Future<Equipo> getTeam(int usuarioId) async {
    final equipo = await (select(equipos)..where((e) => e.usuarioId.equals(usuarioId))).getSingle();

    if (equipo == null) {
      throw Exception("Equipo no encontrado");
    }

    final pokemones = await Future.wait(equipo.pokemonId.map((pokemonId) async {
      final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonId'));

      if (response.statusCode == 200) {
        return Pokemon.fromJson(jsonDecode(response.body), pokemonId);
      } else {
        throw Exception('Failed to load Pokemon');
      }
    }));

    return Equipo(id: equipo.id, usuarioId: equipo.usuarioId, mote: equipo.mote, pokemones: pokemones);
  }
}