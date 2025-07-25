import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_keeper/change_notifiers/notes_provider.dart';
import 'package:notes_keeper/core/constants.dart';
import 'package:provider/provider.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final NotesProvider notesProvider;
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    notesProvider = context.read();
    searchController = TextEditingController()
      ..addListener(() {
        notesProvider.searchTerm = searchController.text;
      });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'Search Notes...',
        hintStyle: TextStyle(fontSize: 16),
        prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
        suffixIcon: ListenableBuilder(
          listenable: searchController,
          builder: (context, clearButton) => searchController.text.isNotEmpty
              ? clearButton!
              : SizedBox.shrink(),
          child: GestureDetector(
            onTap: () {
              searchController.clear();
            },
            child: const Icon(FontAwesomeIcons.circleXmark),
          ),
        ),
        fillColor: white,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.zero,
        prefixIconConstraints: BoxConstraints(minWidth: 42, minHeight: 42),
        suffixIconConstraints: BoxConstraints(minWidth: 42, minHeight: 42),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primary),
        ),
      ),
    );
  }
}
