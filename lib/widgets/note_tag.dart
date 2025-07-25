import 'package:flutter/material.dart';
import 'package:notes_keeper/core/constants.dart';

class NoteTag extends StatelessWidget {
  const NoteTag({required this.label, this.onTap, this.onClosed, super.key});

  final String label;
  final VoidCallback? onClosed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: gray100,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        margin: EdgeInsets.only(right: 4),
        child: Row(
          children: [
            Text(label, style: TextStyle(fontSize: 12, color: gray700)),
            if (onClosed != null) ...[
              SizedBox(width: 4),
              GestureDetector(onTap: onClosed, child: Icon(Icons.close)),
            ],
          ],
        ),
      ),
    );
  }
}
