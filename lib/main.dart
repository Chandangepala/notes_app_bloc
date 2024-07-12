import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_bloc/bloc/note_bloc.dart';
import 'package:notes_app_bloc/database/app_database.dart';
import 'package:notes_app_bloc/home_page.dart';

void main() {
  runApp(BlocProvider(create: (context) => NoteBloc(db: AppDatabase.db), child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

