import 'pokemon.dart';

class Equipo {
  int id;
  int usuarioId;
  String mote;
  List<Pokemon> pokemones;

  Equipo({required this.id, required this.usuarioId, required this.mote, required this.pokemones});
}