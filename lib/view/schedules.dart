import 'package:flutter/material.dart';
import 'package:vsd_scheduler/controller/operations.dart';
import 'package:vsd_scheduler/model/schedule.dart';
import 'package:vsd_scheduler/view/new_schedule.dart';
import 'package:vsd_scheduler/widget/item_card.dart';

class Schedules extends StatefulWidget {
  const Schedules({super.key});

  @override
  State<Schedules> createState() {
    return _SchedulesState();
  }
}

class _SchedulesState extends State<Schedules> {
  List<Schedule> listItems = [];
  bool isLoading = false;
  final _titleController = TextEditingController();

  void _addNew() async {
    final newItem = await Navigator.push<Schedule>(
      context,
      MaterialPageRoute(
        builder: (ctx) => const NewSchedule(),
      ),
    );
    if (newItem == null) return;
    setState(() {
      listItems.add(newItem);
    });
  }

  @override
  void initState() {
    _getDetails();
    super.initState();
  }

  void _getDetails() async {
    isLoading = true;
    var res = await Operations().get('/events').catchError((err) => debugPrint);
    if (res == null) {
      isLoading = false;
      return;
    }
    ;
    debugPrint('Success!');
    setState(() {
      listItems = scheduleFromJson(res);
      isLoading = false;
    });
  }

  void _changeData(int index, String title) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).appBarTheme.backgroundColor!,
      ),
    );
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit'),
        content: TextField(
          controller: _titleController,
          autocorrect: true,
          decoration: InputDecoration(
            labelText: title,
            enabledBorder: border,
            focusedBorder: border,
            errorBorder: border,
            focusedErrorBorder: border,
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_titleController.text.isEmpty) return;
              _updateDetails(index);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _updateDetails(int index) async {
    var id = index + 1;
    var date = DateTime.now();
    var item = Schedule(
      createdAt: date.toIso8601String(),
      title: _titleController.text,
      ischecked: false,
    );
    var res = await Operations()
        .put(
          '/events/$id',
          item,
        )
        .catchError((err) => debugPrint(err));
    if (res == null) {
      debugPrint('failed');
      return;
    }
    debugPrint('Success!');
  }

  void _deleteDetails(int index, String itemId) async {
    var id = itemId;
    var res = await Operations()
        .delete('/events/$id')
        .catchError((err) => debugPrint(err));
    if (res == null) {
      debugPrint('failed');
      return;
    }
    debugPrint('Success!');
    listItems.remove(listItems[index]);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VSD Scheduler'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : listItems.isEmpty
                ? const Center(
                    child: Text('No items found!'),
                  )
                : ListView.builder(
                    itemCount: listItems.length,
                    itemBuilder: (ctx, index) => Dismissible(
                      background: Container(
                        color: const Color.fromARGB(255, 180, 2, 2),
                      ),
                      key: ValueKey(listItems[index].id),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          _changeData(index, listItems[index].title);
                        },
                        child: ItemCard(
                          item: listItems[index],
                        ),
                      ),
                      onDismissed: (direction) {
                        _deleteDetails(index, listItems[index].id!);
                      },
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNew,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
