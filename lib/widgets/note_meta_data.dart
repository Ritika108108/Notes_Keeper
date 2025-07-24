import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_keeper/change_notifiers/new_note_controller.dart';
import 'package:notes_keeper/core/constants.dart';
import 'package:notes_keeper/widgets/dialog_card.dart';
import 'package:notes_keeper/widgets/new_tag_dialog.dart';
import 'package:notes_keeper/widgets/note_icon_button.dart';
import 'package:notes_keeper/widgets/note_tag.dart';
import 'package:provider/provider.dart';

class NoteMetaData extends StatefulWidget {
  const NoteMetaData({required this.isNewNote, super.key});

  final bool isNewNote;

  @override
  State<NoteMetaData> createState() => _NoteMetaDataState();
}

class _NoteMetaDataState extends State<NoteMetaData> {
  late final NewNoteController newNoteController;

  @override
  void initState() {
    super.initState();
    newNoteController = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isNewNote) ...[
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Last Modified',
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray500),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  '07 Decemeber 2023, 03:35 PM',
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray900),
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
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray500),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  '06 Decemeber 2023, 03:35 PM',
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray900),
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
                        builder: (context) => DialogCard(child: NewTagDialog()),
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
      ],
    );
  }
}
