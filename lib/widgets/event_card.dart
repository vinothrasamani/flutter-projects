import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_app/model/event_model.dart';
import 'package:study_app/provider/favorites_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class EventCard extends ConsumerStatefulWidget {
  const EventCard({super.key, required this.eventDetails});

  final EventModel eventDetails;

  @override
  ConsumerState<EventCard> createState() => _EventCardState();
}

class _EventCardState extends ConsumerState<EventCard> {
  int random() {
    return Random().nextInt(50) + 200;
  }

  @override
  Widget build(BuildContext context) {
    final isFavoriteItem =
        ref.watch(favoriteProvider).contains(widget.eventDetails);
    return Card(
      color: Color.fromARGB(255, random(), random(), random()),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(
                widget.eventDetails.imageURL,
              ),
              height: 90,
              width: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.eventDetails.eventName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(widget.eventDetails.formatedDate),
            ],
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: IconButton.filledTonal(
              padding: const EdgeInsets.all(10),
              onPressed: () {
                final favorites = ref
                    .read(favoriteProvider.notifier)
                    .toggleFavorite(widget.eventDetails);

                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    showCloseIcon: true,
                    content: Text(
                      favorites
                          ? 'Event is added to favorite'
                          : 'Event is removed from favorites',
                      style: const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                );
              },
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor:
                    Theme.of(context).colorScheme.onSecondary.withOpacity(0.8),
              ),
              icon: Icon(
                isFavoriteItem ? Icons.favorite : Icons.favorite_border,
                color: isFavoriteItem
                    ? const Color.fromARGB(255, 212, 0, 0)
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
