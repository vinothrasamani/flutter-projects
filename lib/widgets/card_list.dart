import 'package:flutter/material.dart';
import 'package:note_book/models/note_model.dart';
import 'package:note_book/widgets/item_card.dart';

class CardList extends StatelessWidget {
  const CardList({super.key, required this.list, required this.onRemoveItem});
  final List<NoteModel> list;
  final void Function(NoteModel item) onRemoveItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            color: Theme.of(context).colorScheme.error.withOpacity(0.6),
          ),
          margin: const EdgeInsets.all(5),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete,
                  size: 50,
                ),
                Text('This is going to be deleted!!'),
              ],
            ),
          ),
        ),
        key: ValueKey(list[index]),
        child: ItemCard(
          list[index],
        ),
        onDismissed: (direction) {
          onRemoveItem(list[index]);
        },
      ),
    );
  }
}
