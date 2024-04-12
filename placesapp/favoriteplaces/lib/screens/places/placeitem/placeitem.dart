import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/place.dart';
import '../addingplace/location/map/mapscreen.dart';


class PlaceDetailScreen extends StatefulWidget {
  const PlaceDetailScreen({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  String get locationData {
    final lat = widget.place.location.latitude;
    final lng = widget.place.location.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng=&zoom=13&size=600x300&maptype=roadmap &markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyD9kwVbnxiDvJiL2NeglpUE-rZO2xQrebY';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          textAlign: TextAlign.start,
          widget.place.name,
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.file(
              widget.place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MapScreen(
                            initialLocation: widget.place.location,
                            isSelecting: false,
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(locationData),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      textAlign: TextAlign.center,
                      widget.place.location.address,
                      style:  GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
