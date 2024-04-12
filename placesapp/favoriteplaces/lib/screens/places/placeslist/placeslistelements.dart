
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/place.dart';
import '../../../provider/user_places.dart';
import '../placeitem/placeitem.dart';

class PlacesListElements extends ConsumerStatefulWidget {
  const PlacesListElements({super.key, required this.places});

  final List<Place> places;

  @override
  _PlacesListElementsState createState() => _PlacesListElementsState();
}

class _PlacesListElementsState extends ConsumerState<PlacesListElements> {
  void _removePlace(Place place) async {
    final confirm = await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                'Confirm your action',
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                'Are you sure you want to remove this place?',
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    'Yes',
                    style: GoogleFonts.lato(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'No',
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ));

    if (confirm) {
      // If the user confirmed, remove the place and show the snackbar
      ref.read(userPlacesProvider.notifier).removePlace(place);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 10),
          content: Text(
            'Place removed',
          ),
          /*
          action:
           */
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.places.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning,
              color: Colors.white,
              size: 100,
            ),
            Text(
              'No places added yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: widget.places.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(widget.places[index].id),
        background: Container(
          color: Colors.red.withOpacity(0.75),
        ),
        onDismissed: (direction) {
          _removePlace(widget.places[index]);
        },
        child: ListTile(
          title: Card(
              clipBehavior: Clip.hardEdge,
              elevation: 2,
              child: Stack(
                children: [
                  Hero(
                    tag: widget.places[index].id,
                    child: Image.file(
                      widget.places[index].image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        color: Colors.black54,
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.places[index].name,
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.places[index].location.address,
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              )),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PlaceDetailScreen(
                  place: widget.places[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
