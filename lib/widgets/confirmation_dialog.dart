import 'package:flutter/material.dart';
import 'package:notes_keeper/widgets/note_button.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Do you want to save the note ?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
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
