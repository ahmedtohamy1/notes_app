import 'package:flutter/material.dart';
import 'package:noty/screens/home_screen.dart';
import 'package:noty/services/note_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  // init isar db
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}
