import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_keeper/change_notifiers/new_note_controller.dart';
import 'package:notes_keeper/change_notifiers/notes_provider.dart';
import 'package:notes_keeper/core/constants.dart';
import 'package:notes_keeper/models/note.dart';
import 'package:notes_keeper/pages/new_or_edit_note_page.dart';
import 'package:notes_keeper/widgets/no_notes.dart';
import 'package:notes_keeper/widgets/note_fab.dart';
import 'package:notes_keeper/widgets/note_grid.dart';
import 'package:notes_keeper/widgets/note_icon_button.dart';
import 'package:notes_keeper/widgets/note_icon_button_outlined.dart';
import 'package:notes_keeper/widgets/note_list.dart';
import 'package:notes_keeper/widgets/search_field.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<String> dropdownOptions = ['Date Modified', 'Date Created'];

  late String dropdownValue = dropdownOptions.first;

  bool isDescending = true;

  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes Keeper 📒'),
        actions: [
          NoteIconButtonOutlined(
            icon: FontAwesomeIcons.rightFromBracket,
            onPressed: () {},
          ),
        ],
      ),

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
          return notes.isEmpty
              ? NoNotes()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SearchField(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            NoteIconButton(
                              icon: isDescending
                                  ? FontAwesomeIcons.arrowDown
                                  : FontAwesomeIcons.arrowUp,
                              size: 18,
                              onPressed: () {
                                setState(() {
                                  isDescending = !isDescending;
                                });
                              },
                            ),

                            SizedBox(width: 16),
                            DropdownButton(
                              value: dropdownValue,
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: FaIcon(
                                  FontAwesomeIcons.arrowDownWideShort,
                                  size: 18,
                                  color: gray700,
                                ),
                              ),
                              underline: SizedBox.shrink(),
                              borderRadius: BorderRadius.circular(16),
                              isDense: true,
                              items: dropdownOptions
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Row(
                                        children: [
                                          Text(e),
                                          if (e == dropdownValue) ...[
                                            SizedBox(width: 8),
                                            Icon(Icons.check),
                                          ],
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                              selectedItemBuilder: (context) =>
                                  dropdownOptions.map((e) => Text(e)).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                            ),
                            Spacer(),
                            NoteIconButton(
                              icon: isGrid
                                  ? FontAwesomeIcons.tableCellsLarge
                                  : FontAwesomeIcons.bars,
                              size: 18,
                              onPressed: () {
                                setState(() {
                                  isGrid = !isGrid;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: isGrid
                            ? NotesGrid(notes: notes)
                            : NotesList(notes: notes),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
