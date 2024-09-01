import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    super.key,
    required this.updateIndex,
    required this.currentIndex,
  });

  final void Function(int index) updateIndex;
  final int currentIndex;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  double updateSize(position) {
    return currentIndex == position ? 30.0 : 25.0;
  }

  Color updateColor(position) {
    return currentIndex == position
        ? const Color.fromARGB(255, 255, 102, 0)
        : const Color.fromARGB(255, 255, 255, 255);
  }

  Color updateBack(position) {
    return currentIndex == position
        ? const Color.fromARGB(209, 226, 226, 226)
        : const Color.fromARGB(0, 226, 226, 226);
  }

  @override
  void initState() {
    currentIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.primary,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                  widget.updateIndex(0);
                });
              },
              iconSize: width > 750 ? 20 : updateSize(0),
              color: updateColor(0),
              icon: Row(
                children: [
                  const Icon(
                    Icons.home,
                  ),
                  if (width > 750)
                    Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 12,
                        color: updateColor(0),
                      ),
                    ),
                ],
              ),
              style: width > 750
                  ? null
                  : IconButton.styleFrom(backgroundColor: updateBack(0)),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 1;
                  widget.updateIndex(1);
                });
              },
              iconSize: width > 750 ? 20 : updateSize(1),
              color: updateColor(1),
              icon: Row(
                children: [
                  const Icon(
                    Icons.favorite,
                  ),
                  if (width > 750)
                    Text(
                      'Favorites',
                      style: TextStyle(
                        fontSize: 12,
                        color: updateColor(1),
                      ),
                    ),
                ],
              ),
              style: width > 750
                  ? null
                  : IconButton.styleFrom(backgroundColor: updateBack(1)),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 2;
                  widget.updateIndex(2);
                });
              },
              iconSize: width > 750 ? 20 : updateSize(2),
              color: updateColor(2),
              icon: Row(
                children: [
                  const Icon(
                    Icons.person,
                  ),
                  if (width > 750)
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 12,
                        color: updateColor(2),
                      ),
                    ),
                ],
              ),
              style: width > 750
                  ? null
                  : IconButton.styleFrom(backgroundColor: updateBack(2)),
            ),
          ],
        ),
      ),
    );
  }
}
