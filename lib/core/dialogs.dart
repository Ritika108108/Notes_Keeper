import 'package:flutter/material.dart';
import 'package:notes_keeper/widgets/confirmation_dialog.dart';
import 'package:notes_keeper/widgets/delete_confirmation_dialog.dart';
import 'package:notes_keeper/widgets/dialog_card.dart';
import 'package:notes_keeper/widgets/new_tag_dialog.dart';

Future<String?> showNewTagDialog({required BuildContext context, String? tag}) {
  return showDialog<String?>(
    context: context,
    builder: (context) => DialogCard(child: NewTagDialog(tag: tag)),
  );
}

Future<bool?> showConfirmationDialog({required BuildContext context}) {
  return showDialog<bool?>(
    context: context,
    builder: (_) => DialogCard(child: ConfirmationDialog()),
  );
}

Future<bool?> showDeleteConfirmationDialog({required BuildContext context}) {
  return showDialog<bool?>(
    context: context,
    builder: (_) => DialogCard(child: DeleteConfirmationDialog()),
  );
}
