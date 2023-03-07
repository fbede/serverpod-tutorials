import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:simplenoteapp_client/simplenoteapp_client.dart';

final client = Client('http://localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

final notesProvider = StateNotifierProvider<NotesNotifier, List<Note>>((ref) {
  return NotesNotifier();
});

class NotesNotifier extends StateNotifier<List<Note>> {
  List<Note> notes = [];
  bool dialogLoading = false;
  bool deleteLoading = false;

  NotesNotifier() : super([]);

  Future<void> getNotes() async {
    state = await client.notes.getNotes();
  }

  Future<void> createNote(Note note) async {
    dialogLoading = true;
    state = await client.notes.createNote(note);
    dialogLoading = false;
  }

  Future<void> updateNote(Note note) async {
    dialogLoading = true;
    state = await client.notes.updateNote(note);
    dialogLoading = false;
  }

  Future<void> deleteNote(Note note) async {
    deleteLoading = true;
    state = await client.notes.deleteNote(note);
    deleteLoading = false;
  }
}
