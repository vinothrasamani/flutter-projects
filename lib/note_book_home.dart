import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:note_book/chart/chart.dart';
import 'package:note_book/models/note_model.dart';
import 'package:note_book/widgets/card_list.dart';
import 'package:note_book/widgets/input_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteBookHome extends StatefulWidget {
  const NoteBookHome({super.key});

  @override
  State<NoteBookHome> createState() {
    return _NoteBookHomeState();
  }
}

class _NoteBookHomeState extends State<NoteBookHome> {
  List<NoteModel> noteItems = [];

  late SharedPreferences sharedPreferences;

  getSP() async {
    sharedPreferences = await SharedPreferences.getInstance();
    readNote();
  }

  saveNote() {
    List<String> noteList =
        noteItems.map((note) => jsonEncode(note.toJson())).toList();
    sharedPreferences.setStringList('notes', noteList);
  }

  readNote() {
    List<String>? noteList = sharedPreferences.getStringList('notes');
    if (noteList != null) {
      noteItems = noteList
          .map((note) => NoteModel.fromJson(json.decode(note)))
          .toList();
    }
    setState(() {});
  }

  @override
  void initState() {
    getSP();
    super.initState();
  }

  void onAddNewNote(NoteModel model) {
    setState(() {
      noteItems.add(model);
    });
    saveNote();
  }

  void _removeNote(NoteModel model) {
    final cardIndex = noteItems.indexOf(model);
    setState(() {
      noteItems.remove(model);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        content: Text(
          '${model.noteTitle} is deleted!',
          style: const TextStyle(
            color: Color.fromARGB(221, 255, 255, 255),
          ),
        ),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Undo',
          backgroundColor:
              Theme.of(context).appBarTheme.backgroundColor!.withBlue(110),
          textColor: const Color.fromARGB(255, 255, 255, 255),
          onPressed: () {
            setState(() {
              noteItems.insert(cardIndex, model);
            });
          },
        ),
      ),
    );
    saveNote();
  }

  void _openBottomSheet() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => InputOverlay(
        onAddNewNote: onAddNewNote,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final listWidget = Expanded(
      child: noteItems.isEmpty
          ? const Center(
              child: Text('No Notes are available now!'),
            )
          : CardList(
              list: noteItems,
              onRemoveItem: _removeNote,
            ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Image.asset('assets/images/logo.png'),
        ),
        title: const Text('VSD Note'),
        actions: [
          IconButton.filled(
            onPressed: _openBottomSheet,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(
                  noteItems,
                ),
                listWidget,
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(
                    noteItems,
                  ),
                ),
                listWidget,
              ],
            ),
    );
  }
}
