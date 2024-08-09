import 'package:flutter/material.dart';
import 'package:note_book/models/note_model.dart';

class InputOverlay extends StatefulWidget {
  const InputOverlay({super.key, required this.onAddNewNote});
  final void Function(NoteModel model) onAddNewNote;
  @override
  State<InputOverlay> createState() {
    return _InputOverlayState();
  }
}

class _InputOverlayState extends State<InputOverlay> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime? _date;
  DependentCategory _selectedCategory = DependentCategory.entertainment;

  void onSelectDate() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 1);

    final selectedDate = await showDatePicker(
        context: context, initialDate: now, firstDate: first, lastDate: now);

    setState(() {
      _date = selectedDate;
    });
  }

  void onSave() {
    if (_titleController.text.isEmpty ||
        _date == null ||
        _noteController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog.adaptive(
          title: const Text('Invalid Submission!'),
          titleTextStyle: TextStyle(
              color: Theme.of(context).appBarTheme.backgroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 18),
          content: const Text(
              'Your submission is invalid.. Try to fill all the details!'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddNewNote(NoteModel(
        noteTitle: _titleController.text,
        noteContent: _noteController.text,
        date: _date!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSize = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 80, 20, keyboardSize + 10),
        child: Column(
          children: [
            Text('Add New Note',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).appBarTheme.backgroundColor,
                )),
            const SizedBox(
              height: 15,
            ),
            TextField(
              maxLength: 60,
              controller: _titleController,
              decoration: const InputDecoration(
                label: Text('Note Title'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _noteController,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'Your Note',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  icon: Row(
                    children: [
                      Icon(categoryIcon[_selectedCategory]),
                      const Icon(Icons.arrow_drop_down_outlined),
                    ],
                  ),
                  items: DependentCategory.values
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item.name.toString(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                const Spacer(),
                Text(
                  _date == null ? 'Selected date' : formatter.format(_date!),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton.filled(
                  onPressed: onSelectDate,
                  icon: const Icon(Icons.date_range),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: onSave,
                  child: const Text(
                    'Add Note',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
