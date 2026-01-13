import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';

class NoteTileWidget extends StatelessWidget {
  final NoteEntry note;
  final VoidCallback onTap;

  const NoteTileWidget({super.key, required this.note, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: improve tile splash behavior T.T
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          note.title.isNotEmpty ? note.title : '(No Title)',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        subtitle: Row(
          children: [
            Text(
              DateFormat('h:mma MMM d').format(note.lastUpdated),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 8),
            if (note.body.isNotEmpty)
              Expanded(
                child: Text(
                  '| ${note.body}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
