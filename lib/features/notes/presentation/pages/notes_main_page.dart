import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_notes/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:sample_notes/features/notes/presentation/pages/note_editor_page.dart';
import 'package:sample_notes/features/notes/presentation/widgets/note_tile_widget.dart';

class NotesMainPage extends StatelessWidget {
  const NotesMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: extract style into a separate file
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            // if (state.isLoading) {
            //   return const Center(child: CircularProgressIndicator());
            // }

            return state.notes.isEmpty
                ? Center(child: Text('Notes empty.'))
                : ListView.separated(
                    itemCount: state.notes.length,
                    itemBuilder: (context, index) {
                      final note = state.notes[index];

                      return NoteTileWidget(
                        note: note,
                        onTap: () {
                          context.read<NotesBloc>().add(NoteSelected(note.id));
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => NoteEditorPage()),
                          );
                        },
                      );
                    },
                    separatorBuilder: (_, _) => const Divider(height: 16),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<NotesBloc>().add(OpenEditorForNewNote());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NoteEditorPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
