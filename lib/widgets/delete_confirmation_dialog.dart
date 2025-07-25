import 'package:flutter/material.dart';
import 'package:notes_keeper/widgets/note_button.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Do you want to delete the note',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            NoteButton(
              label: 'No',
              onPreseed: () => Navigator.pop(context, false),
              isOutlined: true,
            ),
            SizedBox(width: 8),
            NoteButton(
              label: 'Yes',
              onPreseed: () => Navigator.pop(context, true),
            ),
          ],
        ),
      ],
    );
  }
}
