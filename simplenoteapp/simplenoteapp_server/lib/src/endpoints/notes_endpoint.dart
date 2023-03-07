import 'package:serverpod/server.dart';

import '../generated/notes.dart';

class NotesEndpoint extends Endpoint {
  Future<List<Note>> getNotes(Session session) async {
    return await Note.find(session);
  }

  Future<List<Note>> updateNote(Session session, Note note) async {
    await Note.update(session, note);
    return await Note.find(session);
  }

  Future<List<Note>> createNote(Session session, Note note) async {
    await Note.insert(session, note);
    return await Note.find(session);
  }

  Future<List<Note>> deleteNote(Session session, Note note) async {
    await Note.deleteRow(session, note);
    return await Note.find(session);
  }
}
