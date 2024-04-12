import 'package:favoriteplaces/screens/places/placeslist/placeslistelements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../provider/user_places.dart';
import '../addingplace/addingplace.dart';

class PlacesList extends ConsumerStatefulWidget {

  const PlacesList({super.key});

  void _addingPlace(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddingPlace(),
      ),
    );
  }

  @override
  ConsumerState<PlacesList> createState() => _PlacesListState();
}

class _PlacesListState extends ConsumerState<PlacesList> {

  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    
    final userPlaces = ref.watch(userPlacesProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Places',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              widget._addingPlace(context);
            },
          ),
        ],
      ),
      body: FutureBuilder(future: _placesFuture, builder: (context, snapshot) => snapshot.connectionState ==
        ConnectionState.waiting ? const Center(child: CircularProgressIndicator()) : PlacesListElements(
        places: userPlaces,
      ),)
    );
  }
}