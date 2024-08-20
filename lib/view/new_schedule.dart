import 'package:flutter/material.dart';
import 'package:vsd_scheduler/controller/operations.dart';
import 'package:vsd_scheduler/model/schedule.dart';

class NewSchedule extends StatefulWidget {
  const NewSchedule({super.key});

  @override
  State<NewSchedule> createState() {
    return _NewScheduleState();
  }
}

class _NewScheduleState extends State<NewSchedule> {
  final _controller = TextEditingController();
  bool isLoading = false;

  void addNew(BuildContext context) async {
    if (_controller.text.isEmpty) return;
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });
    var date = DateTime.now();
    var item = Schedule(
      createdAt: date.toIso8601String(),
      title: _controller.text.trim(),
      ischecked: false,
    );
    var res = await Operations()
        .post(
          '/events',
          item,
        )
        .catchError((err) => debugPrint);
    if (res == null) {
      isLoading = false;
      return;
    }
    debugPrint('Success!');
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop(item);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).appBarTheme.backgroundColor!,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Schedule!'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Image.asset('assets/images/back.png'),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Title',
                  enabledBorder: border,
                  focusedBorder: border,
                  errorBorder: border,
                  focusedErrorBorder: border,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: isLoading
                    ? null
                    : () {
                        addNew(context);
                      },
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).appBarTheme.backgroundColor),
                label: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Add event!'),
                icon: isLoading ? null : const Icon(Icons.add_circle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
