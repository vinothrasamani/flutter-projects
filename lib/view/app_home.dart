import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_app/provider/bottom_navigation_provider.dart';
import 'package:study_app/view/home_screen.dart';
import 'package:study_app/view/list_screen.dart';
import 'package:study_app/view/notification_screen.dart';
import 'package:study_app/view/schedule_screen.dart';

class AppHome extends ConsumerStatefulWidget {
  const AppHome({super.key});

  @override
  ConsumerState<AppHome> createState() {
    return _AppHomeState();
  }
}

class _AppHomeState extends ConsumerState<AppHome> {
  Widget currentScreen = const HomeScreen();
  var buttonIndex = 0;

  void _onselectNotification() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NotificationScreen(),
      ),
    );
  }

  void _currentPage(String name) {
    setState(() {
      if (name == 'schedule') {
        currentScreen = const ScheduleScreen();
        buttonIndex = 1;
      } else if (name == 'list') {
        currentScreen = const ListScreen();
        buttonIndex = 2;
      } else {
        currentScreen = const HomeScreen();
        buttonIndex = 0;
      }
    });
  }

  Color _background(var n) {
    return buttonIndex == n
        ? Colors.black
        : const Color.fromARGB(0, 255, 255, 255);
  }

  Color _foreground(var n) {
    return buttonIndex == n
        ? const Color.fromARGB(255, 255, 255, 255)
        : const Color.fromARGB(255, 0, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentScreen,
      floatingActionButton: ref.watch(bottomNavigationProvider)
          ? Container(
              margin: const EdgeInsets.only(left: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0.3, 0.8),
                          blurRadius: 0.5,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _currentPage('home');
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: _background(0),
                            foregroundColor: _foreground(0),
                          ),
                          icon: const Icon(Icons.home_rounded),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            _currentPage('schedule');
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: _background(1),
                            foregroundColor: _foreground(1),
                          ),
                          icon: const Icon(Icons.calendar_month),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            _currentPage('list');
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: _background(2),
                            foregroundColor: _foreground(2),
                          ),
                          icon: const Icon(Icons.list_alt_outlined),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0.3, 0.8),
                          blurRadius: 0.5,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: IconButton(
                      onPressed: _onselectNotification,
                      icon: const Icon(Icons.message),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
