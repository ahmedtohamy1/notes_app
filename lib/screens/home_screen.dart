import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noty/screens/tile_screen.dart';
import 'package:noty/widgets/create_note_dialog.dart';
import 'package:noty/widgets/fab.dart';
import 'package:noty/widgets/note_tiles.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void clearAllNotes(WidgetRef ref) {
    ref.read(noteDatabaseProvider).clearAllNotes();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            fab(
                blurred: false,
                icon: Icons.delete_outline,
                onPressed: () => clearAllNotes(ref),
                heroTag: 'deleteFAB'),
            fab(
                blurred: true,
                icon: Icons.add_circle_outline_sharp,
                onPressed: () => showDialog(
                      context: context,
                      builder: (_) => CreateNoteDialog(ref: ref),
                    ),
                heroTag: 'addFAB'),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white.withAlpha(200),
        title: const Text(
          'Noty Notes.',
        ),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final notesFuture =
              ref.read(noteDatabaseProvider.notifier).fetchNotes();
          return FutureBuilder(
            future: notesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              final notes = ref.watch(noteDatabaseProvider).currentNotes;
              return NoteTiles(notesList: notes);
            },
          );
        },
      ),
    );
  }
}
