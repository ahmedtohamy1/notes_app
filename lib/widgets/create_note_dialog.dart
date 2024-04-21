import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:noty/screens/tile_screen.dart';
import 'package:noty/services/location_manager.dart';

class CreateNoteDialog extends StatefulWidget {
  final WidgetRef ref;
  const CreateNoteDialog({Key? key, required this.ref}) : super(key: key);

  @override
  _CreateNoteDialogState createState() => _CreateNoteDialogState();
}

class _CreateNoteDialogState extends State<CreateNoteDialog> {
  late TextEditingController txtController;

  @override
  void initState() {
    super.initState();
    txtController = TextEditingController();
  }

  @override
  void dispose() {
    txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: txtController,
        decoration: const InputDecoration(
          hintText: 'Enter note text',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () async {
            await LocationManager(widget.ref).getCurrentLocation();
            widget.ref.read(noteDatabaseProvider).addNote(txtController.text,
                widget.ref.read(locationProvider) ?? "Location not available");
            Navigator.pop(context);
          },
          icon: const Icon(Icons.add_circle_outline),
          label: const Text('Add Note'),
        ),
        Text('LAT: ${widget.ref.watch(positionProvider)?.latitude ?? ""}'),
        Text('LNG: ${widget.ref.watch(positionProvider)?.longitude ?? ""}'),
        Text('ADDRESS: ${widget.ref.watch(locationProvider) ?? ""}'),
      ],
    );
  }
}
