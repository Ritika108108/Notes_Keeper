import 'package:flutter/material.dart';
import 'package:notes_keeper/change_notifiers/notes_provider.dart';
import 'package:notes_keeper/core/constants.dart';
import 'package:notes_keeper/pages/main_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes_Keeper 📙',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: background,
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
            backgroundColor: Colors.transparent,
            titleTextStyle: TextStyle(
              color: primary,
              fontSize: 32,
              fontFamily: 'Fredoka',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const MainPage(),
      ),
    );
  }
}
