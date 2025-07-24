import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_keeper/change_notifiers/new_note_controller.dart';
import 'package:notes_keeper/core/constants.dart';
import 'package:notes_keeper/widgets/dialog_card.dart';
import 'package:notes_keeper/widgets/new_tag_dialog.dart';
import 'package:notes_keeper/widgets/note_icon_button.dart';
import 'package:notes_keeper/widgets/note_icon_button_outlined.dart';
import 'package:notes_keeper/widgets/note_tag.dart';
import 'package:provider/provider.dart';

class NewOrEditNotePage extends StatefulWidget {
  const NewOrEditNotePage({required this.isNewNote, super.key});

  final bool isNewNote;

  @override
  State<NewOrEditNotePage> createState() => _NewOrEditNotePageState();
}

class _NewOrEditNotePageState extends State<NewOrEditNotePage> {
  late final FocusNode focusNode;

  late final NewNoteController newNoteController;
  late final QuillController quillController;

  late bool readOnly;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    newNoteController = NewNoteController();
    quillController = QuillController.basic()
      ..addListener(() {
        newNoteController.content = quillController.document;
      });
    if (widget.isNewNote) {
      focusNode.requestFocus();
      readOnly = false;
    } else {
      readOnly = true;
    }
  }

  @override
  void dispose() {
    quillController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NoteIconButtonOutlined(
            icon: FontAwesomeIcons.chevronLeft,
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
        ),
        title: Text(widget.isNewNote ? 'New Note' : 'Edit Note'),
        actions: [
          NoteIconButtonOutlined(
            icon: readOnly ? FontAwesomeIcons.pen : FontAwesomeIcons.bookOpen,
            onPressed: () {
              setState(() {
                readOnly = !readOnly;
                if (readOnly) {
                  FocusScope.of(context).unfocus();
                } else {
                  focusNode.requestFocus();
                }
              });
            },
          ),
          NoteIconButtonOutlined(
            icon: FontAwesomeIcons.check,
            onPressed: () {
              newNoteController.saveNote(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'Title Here',
                hintStyle: TextStyle(color: gray300),
                border: InputBorder.none,
              ),
              canRequestFocus: !readOnly,
              onChanged: (newValue) {
                newNoteController.title = newValue;
              },
            ),
            if (!widget.isNewNote) ...[
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Last Modified',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '07 Decemeber 2023, 03:35 PM',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray900,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Created',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '06 Decemeber 2023, 03:35 PM',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray900,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Text(
                        'Tags',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: gray500,
                        ),
                      ),
                      SizedBox(width: 8),
                      NoteIconButton(
                        icon: FontAwesomeIcons.circlePlus,
                        onPressed: () async {
                          final String? tag = await showDialog<String?>(
                            context: context,
                            builder: (context) =>
                                DialogCard(child: NewTagDialog()),
                          );

                          if (tag != null) {
                            newNoteController.addTag(tag);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Selector<NewNoteController, List<String>>(
                    selector: (_, newNoteController) => newNoteController.tags,
                    builder: (_, tags, __) => tags.isEmpty
                        ? Text(
                            'No tags added',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: gray900,
                            ),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                tags.length,
                                (index) => NoteTag(
                                  label: tags[index],
                                  onClosed: () {
                                    newNoteController.removeTag(index);
                                  },
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(color: gray700, thickness: 2),
            ),
            TextField(
              focusNode: focusNode,
              readOnly: readOnly,
              decoration: InputDecoration(
                hintText: 'Note here...',
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
