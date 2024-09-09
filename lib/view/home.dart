import 'package:flutter/material.dart';
import 'package:progress_tracker/data/dummy_data.dart';
import 'package:progress_tracker/model/data_model.dart';
import 'package:progress_tracker/widget/task_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  bool isTask = true;
  bool isInProgress = false;
  bool isCompleted = false;

  List<DataModel> task = [], inProgress = [], completed = [];
  Color white = Colors.white;

  TextStyle titleStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  Center noList = const Center(
    child: Text('No task available here..'),
  );

  @override
  void initState() {
    task = dummyData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VSD Progress Tracker'),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final height = constraints.maxHeight - 188;

        return Container(
          height: double.maxFinite,
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              ListTile(
                tileColor: Theme.of(context)
                    .appBarTheme
                    .backgroundColor!
                    .withOpacity(0.3),
                leading: const Icon(Icons.work),
                title: Text(
                  'Remaining Tasks',
                  style: titleStyle,
                ),
                trailing: Icon(
                  isTask ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                ),
                onTap: () {
                  setState(() {
                    isTask = !isTask;
                    isCompleted = false;
                    if (isTask) {
                      isInProgress = false;
                    } else {
                      isInProgress = true;
                    }
                  });
                },
              ),
              if (isTask)
                Container(
                  height: height,
                  color: const Color.fromARGB(31, 55, 55, 55),
                  child: task.isEmpty
                      ? noList
                      : ListView.builder(
                          itemCount: task.length,
                          itemBuilder: (context, index) => Dismissible(
                            background: Container(
                              color:
                                  Theme.of(context).appBarTheme.backgroundColor,
                              child: const Center(
                                child: Text(
                                  'Move to InProgress!',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            key: ValueKey(task[index]),
                            onDismissed: (direction) {
                              inProgress.add(task[index]);
                              setState(() {
                                task.removeAt(index);
                              });
                              return;
                            },
                            child: TaskCard(
                              info: task[index],
                              myColor: const Color.fromARGB(255, 193, 245, 255),
                            ),
                          ),
                        ),
                ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                tileColor: Theme.of(context)
                    .appBarTheme
                    .backgroundColor!
                    .withOpacity(0.3),
                leading: const Icon(Icons.work_history),
                title: Text(
                  'InProgress',
                  style: titleStyle,
                ),
                trailing: Icon(
                  isInProgress
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
                onTap: () {
                  setState(() {
                    isInProgress = !isInProgress;
                    isTask = false;
                    if (isInProgress) {
                      isCompleted = false;
                    } else {
                      isCompleted = true;
                    }
                  });
                },
              ),
              if (isInProgress)
                Container(
                  height: height,
                  color: const Color.fromARGB(31, 55, 55, 55),
                  child: inProgress.isEmpty
                      ? noList
                      : ListView.builder(
                          itemCount: inProgress.length,
                          itemBuilder: (context, index) => Dismissible(
                            background: Container(
                              color:
                                  Theme.of(context).appBarTheme.backgroundColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.work,
                                    color: white,
                                  ),
                                  Text(
                                    ' <= || => ',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    color: white,
                                  ),
                                ],
                              ),
                            ),
                            key: ValueKey(inProgress[index]),
                            onDismissed: (direction) {
                              if (direction == DismissDirection.startToEnd) {
                                completed.add(inProgress[index]);
                              } else {
                                task.add(inProgress[index]);
                              }
                              setState(() {
                                inProgress.removeAt(index);
                              });
                              return;
                            },
                            child: TaskCard(
                              info: inProgress[index],
                              myColor: const Color.fromARGB(255, 211, 255, 193),
                            ),
                          ),
                        ),
                ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                tileColor: Theme.of(context)
                    .appBarTheme
                    .backgroundColor!
                    .withOpacity(0.3),
                leading: const Icon(Icons.check_circle),
                title: Text(
                  'Completed!',
                  style: titleStyle,
                ),
                trailing: Icon(
                  isCompleted
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
                onTap: () {
                  setState(() {
                    isCompleted = !isCompleted;
                    isInProgress = false;
                    if (isCompleted) {
                      isTask = false;
                    } else {
                      isTask = true;
                    }
                  });
                },
              ),
              if (isCompleted)
                Container(
                  height: height,
                  color: const Color.fromARGB(31, 55, 55, 55),
                  child: completed.isEmpty
                      ? noList
                      : ListView.builder(
                          itemCount: completed.length,
                          itemBuilder: (context, index) => Dismissible(
                            key: ValueKey(completed[index]),
                            background: Container(
                              color:
                                  Theme.of(context).appBarTheme.backgroundColor,
                              child: const Center(
                                child: Text(
                                  'Move to InProgress!',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            onDismissed: (direction) {
                              inProgress.add(completed[index]);
                              setState(() {
                                completed.removeAt(index);
                              });
                              return;
                            },
                            child: TaskCard(
                              info: completed[index],
                              myColor: const Color.fromARGB(255, 244, 193, 255),
                            ),
                          ),
                        ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
