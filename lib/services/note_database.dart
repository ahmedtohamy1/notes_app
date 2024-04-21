import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:noty/models/note_model.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;
// init db
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteModelSchema], directory: dir.path);
  }

// list of notes
  final List<NoteModel> currentNotes = [];

// create note
  Future<void> addNote(String text, String location) async {
    // create note obj
    final newNote = NoteModel()..text = text;
    newNote.location = location;
    // put into isar db
    await isar.writeTxn(() => isar.noteModels.put(newNote));
    // refetch db
    fetchNotes();
    notifyListeners();
  }

// read note
  Future<void> fetchNotes() async {
    List<NoteModel> fetchedNotes = await isar.noteModels.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

// update note
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.noteModels.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.noteModels.put(existingNote));
      await fetchNotes();
    }
  }

  // find note by ID
  Future<NoteModel?> findNote(int id) async {
    return await isar.noteModels.get(id);
  }

// rm rf note

  Future<void> rmrfNote(int id) async {
    await isar.writeTxn(() => isar.noteModels.delete(id));
    await fetchNotes();
  }

  Future<void> clearAllNotes() async {
    await isar.writeTxn(() => isar.noteModels.where().deleteAll());
    currentNotes.clear();
    notifyListeners();
  }
}
