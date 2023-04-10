// import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../main.dart';
import 'package:latlong2/latlong.dart' as latLng;
// import 'mapbox_navigation/main.dart';

import 'mapbox_requests.dart';
// import '';

Future <Map> getDirectionsAPIResponse(LatLng currentLatLng) async{
  print("${currentLatLng.latitude},${currentLatLng.longitude}");

  final response = await getDrivingroute(currentLatLng , LatLng(23.196299,72.63394));

  print("${currentLatLng.latitude},${currentLatLng.longitude}");

  Map geometry = response['routes'][0]['geometry'];
  num duration = response['routes'][0]['duration'];
  num distance = response['routes'][0]['distance'];

  print(distance);

  Map modifiedResponse = {
    "geometry": geometry,
    "duration": duration,
    "distance": distance,
  };

  return modifiedResponse;
}

void saveDirectionsAPIResponse(String response){
  sharedPreferences.setString('destiny',response);
}

// Map getGeometryFromSharedPrefs(String key) {
//   Map geometry = getDecodedResponseFromSharedPrefs(key)['geometry'];
//   return geometry;
// }

// Map getDecodedResponseFromSharedPrefs(String key) {
//   // String key = 'restaurant--$index';
//   Map response = json.decode(sharedPreferences.getString(key)!);
//   return response;
// }

