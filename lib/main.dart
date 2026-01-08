import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_notes/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:sample_notes/features/notes/presentation/pages/notes_main_page.dart';

import 'core/di/injection.dart' as di;

///
/// ### NOTES ###
///
/// As of this version:
/// - bug: it triggers update when note doesn't change (shouldn't be)
/// - needs logger
/// - barely any docs
/// - haven't tried freezed
/// - GIVEN-WHEN-THEN not implemented in test specs
/// - getNoteEntry
///   - which gets a note by id from local data storage
///   - is unnecessarily implemented
///   - but for the sake of the demo, I used it nalang
/// - UI/UX needs work
/// - I tried implementing the app to have no explicit buttons for create/update/delete
/// - They are triggered when pressing back from the NoteEditorPage and will depend on the current NoteState
/// - (I tried mirroring my phone's behavior)
///   - create is triggered when going through FAB flow (isNewNote == true)
///   - update is triggered when selected note exists (isNewNote == false, selectedNote != null)
///     - source of bug draft is not compared to selectedNote
///   - delete is triggered when draft is empty
///
///

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
