import 'package:flutter/material.dart';
import 'package:notes_keeper/core/constants.dart';
import 'package:notes_keeper/widgets/note_button.dart';

class NewTagDialog extends StatefulWidget {
  const NewTagDialog({super.key, this.tag});

  final String? tag;

  @override
  State<NewTagDialog> createState() => _NewTagDialogState();
}

class _NewTagDialogState extends State<NewTagDialog> {
  late final TextEditingController tagController;

  late final GlobalKey<FormFieldState> tagKey;

  @override
  void initState() {
    super.initState();
    tagController = TextEditingController(text: widget.tag);
    tagKey = GlobalKey();
  }

  @override
  void dispose() {
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Add tag',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 24),
        TextFormField(
          key: tagKey,
          controller: tagController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Add tag (<16 characters)',
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            isDense: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          validator: (value) {
            if (value!.trim().isEmpty) {
              return 'No tags added';
            } else if (value.trim().length > 16) {
              return 'Tags should not be more than 16 characters';
            }
            return null;
          },
          onChanged: (newValue) {
            tagKey.currentState?.validate();
          },
        ),
        SizedBox(height: 16),
        NoteButton(
          label: 'Add',
          onPreseed: () {
            if (tagKey.currentState?.validate() ?? false) {
              Navigator.pop(context, tagController.text.trim());
            }
          },
        ),
      ],
    );
  }
}
