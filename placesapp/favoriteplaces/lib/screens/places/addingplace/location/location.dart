import 'dart:convert';

import 'package:favoriteplaces/model/place.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import 'map/mapscreen.dart';


class LocationInpute extends StatefulWidget{
   LocationInpute({
    super.key,
    required this.onSelectLocation,
    required this.locationData,
  });

  final void Function(PlaceLocation location) onSelectLocation;

  PlaceLocation? locationData;

  //final void Function(double lat, double lng) onSelectPlace;

  @override
  _LocationInputeState createState() => _LocationInputeState();
}

class _LocationInputeState extends State<LocationInpute>{


  String get locationData{
    if(widget.locationData == null){
      return 'No Location Chosen';
    }
    final lat = widget.locationData!.latitude;
    final lng = widget.locationData!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng=&zoom=13&size=600x300&maptype=roadmap &markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyD9kwVbnxiDvJiL2NeglpUE-rZO2xQrebY';
  }

  var _isGettingLocation = false;

  void _getCurrentUserLocation() async {

    try{
      Location location = Location();

      bool serviceEnabled;
      PermissionStatus permissionGranted;
      LocationData locationData;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      setState(() {
        _isGettingLocation = true;
      });

      locationData = await location.getLocation();

      final lat = locationData.latitude;
      final lon = locationData.longitude;

      if(lat == null || lon == null){
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not fetch location. Please try again later.'),
          ),
        );
        return;
      }

      final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=AIzaSyD9kwVbnxiDvJiL2NeglpUE-rZO2xQrebY');

      final response = await http.get(url);

      final responsedata = json.decode(response.body);

      final address = responsedata['results'][0]['formatted_address'];

      print(address);

      setState(() {
        widget.locationData = PlaceLocation(
          latitude: lat,
          longitude: lon,
          address: address,
        );
        _isGettingLocation = false;
      });

      widget.onSelectLocation(widget.locationData!);

    } catch(error){
      return;
    }
  }

  void _selectOnmap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const MapScreen(
          isSelecting: true,
        ),
      ),
    );

    if(selectedLocation == null){
      return;
    }

    final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=${selectedLocation.latitude},${selectedLocation.longitude}&key=AIzaSyD9kwVbnxiDvJiL2NeglpUE-rZO2xQrebY');

    final response = await http.get(url);

    final responsedata = json.decode(response.body);

    final address = responsedata['results'][0]['formatted_address'];

    setState(() {
      widget.locationData = PlaceLocation(
        latitude: selectedLocation.latitude,
        longitude: selectedLocation.longitude,
        address: address,
      );
    });

    widget.onSelectLocation(widget.locationData!);
  }

  @override
  Widget build(BuildContext context){

    Widget previewContent = Text(
      'No Location Chosen',
      textAlign: TextAlign.center,
      style: GoogleFonts.lato(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Colors.black
      ),
    );

    if(_isGettingLocation == true){
      previewContent = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if(widget.locationData != null){
      previewContent = Image.network(
        locationData,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }




    return Column(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: Center(
            child: previewContent,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: (){
                _getCurrentUserLocation();
              },
              icon: const Icon(Icons.location_on, color: Colors.black),
              label: Text('Current Location', style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 10,
                color: Colors.black,
              ),),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            TextButton.icon(
              onPressed: (){
                _selectOnmap();
              },
              icon: const Icon(Icons.map, color: Colors.black),
              label:  Text('Select on Map', style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 10,
                color: Colors.black,
              ),),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        )
      ],
    );
  }
}