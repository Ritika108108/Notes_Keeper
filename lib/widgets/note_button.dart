import 'package:flutter/material.dart';
import 'package:notes_keeper/core/constants.dart';

class NoteButton extends StatelessWidget {
  const NoteButton({
    super.key,
    required this.label,
    this.onPreseed,
    this.isOutlined = false,
  });

  final String label;
  final VoidCallback? onPreseed;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(offset: Offset(2, 2), color: isOutlined ? primary : black),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onPreseed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? white : primary,
          foregroundColor: isOutlined ? primary : white,
          side: BorderSide(color: isOutlined ? primary : black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(label),
      ),
    );
  }
}
