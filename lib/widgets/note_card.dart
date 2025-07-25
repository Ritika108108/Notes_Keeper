import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_keeper/change_notifiers/new_note_controller.dart';
import 'package:notes_keeper/change_notifiers/notes_provider.dart';
import 'package:notes_keeper/core/constants.dart';
import 'package:notes_keeper/core/dialogs.dart';
import 'package:notes_keeper/core/utils.dart';
import 'package:notes_keeper/models/note.dart';
import 'package:notes_keeper/pages/new_or_edit_note_page.dart';
import 'package:notes_keeper/widgets/note_tag.dart';
import 'package:provider/provider.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({required this.note, this.isInGrid, super.key});

  final Note note;

  final isInGrid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => NewNoteController()..note = note,
              child: NewOrEditNotePage(isNewNote: false),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: white,
          border: Border.all(color: primary, width: 2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: primary.withOpacity(0.5), offset: Offset(4, 4)),
          ],
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note.title != null) ...[
              Text(
                note.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: gray900,
                ),
              ),
              SizedBox(height: 4),
            ],
            if (note.tags != null) ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    note.tags!.length,
                    (index) => NoteTag(label: note.tags![index]),
                  ),
                ),
              ),
              SizedBox(height: 4),
            ],
            if (note.content != null)
              isInGrid
                  ? Expanded(
                      child: Text(
                        Document.fromJson(
                          jsonDecode(note.content!),
                        ).toPlainText().trim(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: gray700),
                      ),
                    )
                  : Text(
                      Document.fromJson(
                        jsonDecode(note.content!),
                      ).toPlainText().trim(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: gray700),
                    ),
            if (isInGrid) Spacer(),

            Row(
              children: [
                Text(
                  toShortDate(note.dateModified),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: gray500,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    final shouldDelete =
                        await showDeleteConfirmationDialog(context: context) ??
                        false;
                    if (shouldDelete && context.mounted) {
                      context.read<NotesProvider>().deleteNote(note);
                    }
                  },
                  child: FaIcon(
                    FontAwesomeIcons.trash,
                    color: gray500,
                    size: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
