import 'package:flutter/material.dart';
import 'package:notes_keeper/core/constants.dart';

class NoteTag extends StatelessWidget {
  const NoteTag({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: gray100,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      margin: EdgeInsets.only(right: 4),
      child: Text(label, style: TextStyle(fontSize: 12, color: gray700)),
    );
  }
}
