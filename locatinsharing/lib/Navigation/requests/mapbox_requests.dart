import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../screens/navigation.dart';
import '../helper/dio_exceptions.dart';
import 'package:locatinsharing/main.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:dio/dio.dart';



String baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
String accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN']!;
String navType = 'driving';


Dio _dio = Dio();

Future getDrivingroute(LatLng source, LatLng destination) async {
  String url = '$baseUrl/$navType/${source.longitude},${source.latitude};${destination.longitude},${destination.latitude}?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=$accessToken';
  print(url);
  try {
    _dio.options.contentType = Headers.jsonContentType;
    final responseData= await _dio.get(url);
    // print(responseData.data);
    return responseData.data;
  } catch(e){
    final errorMessage = DioExceptions.fromDioError(e as DioError).toString();
    debugPrint(errorMessage);
  }
}