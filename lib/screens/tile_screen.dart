import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noty/providers/providers.dart';
import 'package:noty/models/note_model.dart';
import 'package:noty/widgets/fab.dart';

final noteDatabaseProvider = Providers().noteDatabaseProvider;

class TileScreen extends ConsumerWidget {
  const TileScreen(this.noteId, {Key? key}) : super(key: key);

  final int noteId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: fab(
          icon: Icons.delete_outline_rounded,
          onPressed: () {
            ref.read(noteDatabaseProvider).rmrfNote(noteId);
            Navigator.pop(context);
          },
          heroTag: 'fabNew',
          blurred: false,
        ),
      ),
      appBar: AppBar(
        title: Text('Note Details'),
      ),
      body: FutureBuilder<NoteModel?>(
        future: ref.read(noteDatabaseProvider).findNote(noteId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return _buildNoteDetails(context, snapshot.data!);
            } else {
              return Center(child: Text("No note found."));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildNoteDetails(BuildContext context, NoteModel note) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Note:',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            note.text,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Location:',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            note.location,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
