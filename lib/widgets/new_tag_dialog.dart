import 'package:flutter/material.dart';
import 'package:notes_keeper/core/constants.dart';

class NewTagDialog extends StatelessWidget {
  const NewTagDialog({super.key});

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
        TextField(
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
          ),
        ),
        SizedBox(height: 24),
        DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(offset: Offset(2, 2), color: black)],
            borderRadius: BorderRadius.circular(8),
          ),
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Add'),
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: white,
              side: BorderSide(color: black),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
      ],
    );
  }
}
