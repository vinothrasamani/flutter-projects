import 'package:flutter/material.dart';
import 'package:note_book/models/note_model.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
    this.note, {
    super.key,
  });
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  note.noteTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Icon(categoryIcon[note.category]),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(note.noteContent),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  note.formatedDate,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
