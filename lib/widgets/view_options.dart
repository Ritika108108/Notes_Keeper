import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_keeper/change_notifiers/notes_provider.dart';
import 'package:notes_keeper/core/constants.dart';
import 'package:notes_keeper/enums/order_options.dart';
import 'package:notes_keeper/widgets/note_icon_button.dart';
import 'package:provider/provider.dart';

class ViewOptions extends StatefulWidget {
  const ViewOptions({super.key});

  @override
  State<ViewOptions> createState() => _ViewOptionsState();
}

class _ViewOptionsState extends State<ViewOptions> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(
      builder: (_, notesProvider, __) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            NoteIconButton(
              icon: notesProvider.isDescending
                  ? FontAwesomeIcons.arrowDown
                  : FontAwesomeIcons.arrowUp,
              size: 18,
              onPressed: () {
                setState(() {
                  notesProvider.isDescending = !notesProvider.isDescending;
                });
              },
            ),

            SizedBox(width: 16),
            DropdownButton<OrderOptions>(
              value: notesProvider.orderBy,
              icon: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: FaIcon(
                  FontAwesomeIcons.arrowDownWideShort,
                  size: 18,
                  color: gray700,
                ),
              ),
              underline: SizedBox.shrink(),
              borderRadius: BorderRadius.circular(16),
              isDense: true,
              items: OrderOptions.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          Text(e.name),
                          if (e == notesProvider.orderBy) ...[
                            SizedBox(width: 8),
                            Icon(Icons.check),
                          ],
                        ],
                      ),
                    ),
                  )
                  .toList(),
              selectedItemBuilder: (context) =>
                  OrderOptions.values.map((e) => Text(e.name)).toList(),
              onChanged: (newValue) {
                setState(() {
                  notesProvider.orderBy = newValue!;
                });
              },
            ),
            Spacer(),
            NoteIconButton(
              icon: notesProvider.isGrid
                  ? FontAwesomeIcons.tableCellsLarge
                  : FontAwesomeIcons.bars,
              size: 18,
              onPressed: () {
                setState(() {
                  notesProvider.isGrid = !notesProvider.isGrid;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
