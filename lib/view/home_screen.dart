import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_app/data/dummy_class.dart';
import 'package:study_app/model/event_model.dart';
import 'package:study_app/provider/bottom_navigation_provider.dart';
import 'package:study_app/widgets/class_card.dart';
import 'package:study_app/widgets/event_card.dart';
import 'package:study_app/widgets/profile.dart';
import 'package:study_app/data/dummy_event.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<EventModel> filteredEvents = [];
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    filteredEvents = dummyEvent;
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    ref
        .read(bottomNavigationProvider.notifier)
        .scrollControl(_scrollController);
  }

  TextStyle _style(double n) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: n,
    );
  }

  Widget section(String title, void Function() onPress) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 22,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: _style(24),
          ),
          const Spacer(),
          TextButton(
            onPressed: onPress,
            child: Text(
              'See All',
              style: _style(18),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keybordSize = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      controller: _scrollController,
      child: Container(
        margin: EdgeInsets.only(
          top: 50,
          left: 5,
          right: 5,
          bottom: keybordSize,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              child: Column(
                children: [
                  const Profile(),
                  const SizedBox(
                    height: 15,
                  ),
                  SearchBar(
                    controller: _searchController,
                    leading: const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.search,
                      ),
                    ),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    ),
                    shadowColor: WidgetStateColor.transparent,
                    hintText: 'Search',
                    onChanged: (value) {
                      setState(() {
                        filteredEvents = dummyEvent
                            .where((item) => item.eventName
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (_searchController.text.isEmpty)
              Column(
                children: [
                  section(
                    'Next Class',
                    () {},
                  ),
                  if (dummyClass.isEmpty)
                    const Text(
                      'No items found!',
                      style: TextStyle(fontSize: 18),
                    ),
                  for (final item in dummyClass)
                    if (dummyClass.indexOf(item) == 0)
                      ClassCard(
                        item: item,
                      ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            section(
              'Events',
              () {},
            ),
            if (filteredEvents.isEmpty)
              const Text(
                'No items found!',
                style: TextStyle(fontSize: 18),
              ),
            for (final item in filteredEvents)
              if (filteredEvents.indexOf(item) <= 5)
                EventCard(
                  eventDetails: item,
                ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
