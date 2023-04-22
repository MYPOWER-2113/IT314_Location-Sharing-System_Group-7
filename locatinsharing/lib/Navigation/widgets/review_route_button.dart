import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../helper/directions_handler.dart';
import '../helper/shared_prefs.dart';
import '../screens/review_route.dart';

Widget reviewRideFaButton(BuildContext context) {
  return FloatingActionButton.extended(
      icon: const Icon(Icons.local_taxi),
      onPressed: () async {
        LatLng sourceLatLng = getTripLatLngFromSharedPrefs('source');
        LatLng destinationLatLng = getTripLatLngFromSharedPrefs('destination');
        Map modifiedResponse =
        await getDirectionsAPIResponse(sourceLatLng, destinationLatLng);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    ReviewRide(modifiedResponse: modifiedResponse)));
      },
      label: const Text('Review Ride'));
}
