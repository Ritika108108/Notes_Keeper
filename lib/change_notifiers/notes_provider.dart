import 'package:flutter/material.dart';
import 'package:notes_keeper/models/note.dart';

class NotesProvider extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => [..._notes];
}
