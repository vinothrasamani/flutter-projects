import 'package:favorite_places/model/place_model.dart';
import 'package:favorite_places/provider/place_provider.dart';
import 'package:favorite_places/view/add_new.dart';
import 'package:favorite_places/view/place_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    _placesFuture = ref.read(placeProvider.notifier).loadPlaces();
    super.initState();
  }

  void _addNewPlace() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => const AddNew(),
      ),
    );
  }

  void _onItemSelected(PlaceModel item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => PlaceDetails(place: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Awesome Places'),
        actions: [
          IconButton.filledTonal(
            onPressed: _addNewPlace,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
        child: FutureBuilder(
          future: _placesFuture,
          builder: (ctx, snap) => snap.connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : places.isEmpty
                  ? const Center(
                      child: Text(
                        'No places added yet!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: places.length,
                      itemBuilder: (context, index) => ListTile(
                        splashColor: const Color.fromARGB(51, 190, 190, 190),
                        leading: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 151, 1, 144),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Text(
                            (index + 1).toString(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        title: Text(
                          places[index].placeName,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          places[index].addr(),
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        trailing: CircleAvatar(
                          radius: 23,
                          backgroundImage: FileImage(
                            places[index].image,
                          ),
                        ),
                        onTap: () {
                          _onItemSelected(places[index]);
                        },
                        titleAlignment: ListTileTitleAlignment.titleHeight,
                      ),
                    ),
        ),
      ),
    );
  }
}
