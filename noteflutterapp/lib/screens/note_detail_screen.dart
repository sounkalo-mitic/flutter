import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/api_service.dart';
import 'update_note_screen.dart';

class NoteDetailScreen extends StatelessWidget {
  final Note note;

  NoteDetailScreen({required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Title: ${note.title}', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8),
            Text('Content: ${note.content}', style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateNoteScreen(note: note),
                  ),
                );
              },
              child: Text('Update Note'),
            ),
            ElevatedButton(
              onPressed: () {
                ApiService().deleteNote(note.id).then((_) {
                  Navigator.pop(context);
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to delete note')),
                  );
                });
              },
              child: Text('Delete Note'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
