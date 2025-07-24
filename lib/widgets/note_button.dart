import 'package:flutter/material.dart';
import 'package:notes_keeper/core/constants.dart';

class NoteButton extends StatelessWidget {
  const NoteButton({super.key, required this.label, this.onPreseed});

  final String label;
  final VoidCallback? onPreseed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPreseed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: white,
        side: BorderSide(color: black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(label),
    );
  }
}
