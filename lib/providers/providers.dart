import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noty/services/note_database.dart';

class Providers {
  final noteDatabaseProvider =
      ChangeNotifierProvider<NoteDatabase>((ref) => NoteDatabase());

  final locationProvider = StateProvider<String>((ref) => "");
}
