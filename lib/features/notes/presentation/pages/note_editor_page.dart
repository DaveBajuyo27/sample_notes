import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_notes/features/notes/presentation/bloc/notes_bloc.dart';

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({super.key});

  @override
  State<StatefulWidget> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditorPage> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  late bool _isNewNote;

  @override
  void initState() {
    super.initState();
    final state = context.read<NotesBloc>().state;
    _isNewNote = state.isNewNote ?? false;

    if (_isNewNote == true) {
      _titleController = TextEditingController();
      _bodyController = TextEditingController();
    } else {
      final selectedNote = state.selectedNote!;
      _titleController = TextEditingController(text: selectedNote.title);
      _bodyController = TextEditingController(text: selectedNote.body);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _saveDraft() {
    context.read<NotesBloc>().add(
      EditorClosed(_titleController.text, _bodyController.text, _isNewNote),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<NotesBloc>().state;

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        _saveDraft();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.white),
            ),
          ),
          backgroundColor: Colors.grey[100],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: state.errorMessage != null
              ? Center(child: Text(state.errorMessage!))
              : Column(
                  children: [
                    // Title input
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(hintText: 'Title'),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 16),
                    // Body input
                    Expanded(
                      child: TextField(
                        controller: _bodyController,
                        decoration: const InputDecoration(
                          hintText: 'Write your note here...',
                        ),
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
