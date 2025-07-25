import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_keeper/change_notifiers/new_note_controller.dart';
import 'package:notes_keeper/core/constants.dart';
import 'package:notes_keeper/core/dialogs.dart';
import 'package:notes_keeper/widgets/note_icon_button_outlined.dart';
import 'package:notes_keeper/widgets/note_metadata.dart';
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
  late final TextEditingController titleController;
  late final QuillController quillController;
  bool readOnly = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    newNoteController = context.read<NewNoteController>();
    titleController = TextEditingController(text: newNoteController.title);
    quillController = QuillController.basic()
      ..addListener(() {
        newNoteController.content = quillController.document;
      });
    readOnly = !widget.isNewNote;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isNewNote) {
        focusNode.requestFocus();
        readOnly = false;
      } else {
        readOnly = true;
        quillController.document = newNoteController.content;
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    quillController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        if (!newNoteController.canSaveNote) {
          Navigator.pop(context);
          return;
        }

        final bool? shouldSave = await showConfirmationDialog(context: context);
        if (shouldSave == null) return;

        if (!context.mounted) return;

        if (shouldSave) {
          newNoteController.saveNote(context);
        }
        Navigator.pop(context);
      },
      child: Scaffold(
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
            Selector<NewNoteController, bool>(
              selector: (context, newNoteController) =>
                  newNoteController.readOnly,

              builder: (context, readOnly, child) => NoteIconButtonOutlined(
                icon: readOnly
                    ? FontAwesomeIcons.pen
                    : FontAwesomeIcons.bookOpen,
                onPressed: () {
                  final controller = context.read<NewNoteController>();
                  controller.readOnly = !controller.readOnly;
                  if (controller.readOnly) {
                    FocusScope.of(context).unfocus();
                  } else {
                    focusNode.requestFocus();
                  }
                },
              ),
            ),
            Selector<NewNoteController, bool>(
              selector: (_, newNoteController) => newNoteController.canSaveNote,
              builder: (_, canSaveNote, __) => NoteIconButtonOutlined(
                icon: FontAwesomeIcons.check,
                onPressed: canSaveNote
                    ? () {
                        newNoteController.saveNote(context);
                        Navigator.pop(context);
                      }
                    : null,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Selector<NewNoteController, bool>(
                selector: (context, controller) => controller.readOnly,
                builder: (context, readOnly, child) => TextField(
                  controller: titleController,
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
              ),
              NoteMetadata(note: newNoteController.note),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(color: gray700, thickness: 2),
              ),
              Expanded(
                child: Selector<NewNoteController, bool>(
                  selector: (_, controller) => controller.readOnly,
                  builder: (_, readOnly, __) => TextField(
                    controller: newNoteController.textController,
                    focusNode: focusNode,
                    readOnly: readOnly,
                    autofocus: !readOnly,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      hintText: 'Note here...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
