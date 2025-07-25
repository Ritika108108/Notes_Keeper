import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_keeper/change_notifiers/new_note_controller.dart';
import 'package:notes_keeper/change_notifiers/notes_provider.dart';
import 'package:notes_keeper/models/note.dart';
import 'package:notes_keeper/pages/new_or_edit_note_page.dart';
import 'package:notes_keeper/widgets/no_notes.dart';
import 'package:notes_keeper/widgets/note_fab.dart';
import 'package:notes_keeper/widgets/note_grid.dart';
import 'package:notes_keeper/widgets/note_icon_button_outlined.dart';
import 'package:notes_keeper/widgets/note_list.dart';
import 'package:notes_keeper/widgets/search_field.dart';
import 'package:notes_keeper/widgets/view_options.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes Keeper 📒')),

      floatingActionButton: NoteFab(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => NewNoteController(),
                child: const NewOrEditNotePage(isNewNote: true),
              ),
            ),
          );
        },
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          final List<Note> notes = notesProvider.notes;
          return notes.isEmpty && notesProvider.searchTerm.isEmpty
              ? NoNotes()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SearchField(),
                      if (notes.isNotEmpty) ...[
                        ViewOptions(),

                        Expanded(
                          child: notesProvider.isGrid
                              ? NotesGrid(notes: notes)
                              : NotesList(notes: notes),
                        ),
                      ] else
                        Expanded(
                          child: Center(
                            child: Text(
                              'No notes found!',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
