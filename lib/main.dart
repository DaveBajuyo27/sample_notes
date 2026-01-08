import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_notes/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:sample_notes/features/notes/presentation/pages/notes_main_page.dart';

import 'core/di/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.configureDependencies();
  runApp(
    BlocProvider(
      create: (_) {
        final bloc = di.sl<NotesBloc>();
        bloc.add(NotesOpened());
        return bloc;
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: extract theme data and colors into a separate file
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(scaffoldBackgroundColor: Colors.grey[100]),
      home: NotesMainPage(),
    );
  }
}
