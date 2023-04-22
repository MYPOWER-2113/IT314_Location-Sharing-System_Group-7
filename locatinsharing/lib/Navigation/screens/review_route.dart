import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:mapbox_turn_by_turn/helpers/mapbox_handler.dart';
// import 'package:mapbox_turn_by_turn/helpers/shared_prefs.dart';
import '../helper/directions_handler.dart';
import '../helper/shared_prefs.dart';
import '../helper/commons.dart';
import '../widgets/review_route_bottom.dart';

class ReviewRide extends StatefulWidget {
  final Map modifiedResponse;
  const ReviewRide({Key? key, required this.modifiedResponse})
      : super(key: key);

  @override
  State<ReviewRide> createState() => _ReviewRideState();
}

class _ReviewRideState extends State<ReviewRide> {
  // Mapbox Maps SDK related
  final List<CameraPosition> _kTripEndPoints = [];
  late MapboxMapController controller;
  late CameraPosition _initialCameraPosition;

  // Directions API response related
  late String distance;
  late String dropOffTime;
  late Map geometry;

  @override
  void initState() {
    // initialise distance, dropOffTime, geometry
    _initialiseDirectionsResponse();

    // initialise initialCameraPosition, address and trip end points
    _initialCameraPosition = CameraPosition(target: getCenterCoordinatesForPolyline(geometry), zoom: 11);

    for (String type in ['source', 'destination']) {
      _kTripEndPoints.add(CameraPosition(target: getTripLatLngFromSharedPrefs(type)));
    }

    super.initState();
  }

  _initialiseDirectionsResponse() {
    distance = (widget.modifiedResponse['distance'] / 1000).toStringAsFixed(1);
    dropOffTime = getDropOffTime(widget.modifiedResponse['duration']);
    geometry = widget.modifiedResponse['geometry'];
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _onStyleLoadedCallback() async {
    // for (int i = 0; i < _kTripEndPoints.length; i++) {
    //   String iconImage = i == 0 ? 'circle' : 'square';
    //   await controller.addSymbol(
    //     SymbolOptions(
    //       geometry: _kTripEndPoints[i].target,
    //       iconSize: 0.1,
    //       iconImage: "assets/icon/$iconImage.png",
    //     ),
    //   );
    // }
    _addSourceAndLineLayer();
  }

  _addSourceAndLineLayer() async {
    // Create a polyLine between source and destination
    final _fills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 0,
          "properties": <String, dynamic>{},
          "geometry": geometry,
        },
      ],
    };

    // Add new source and lineLayer
    await controller.addSource("fills", GeojsonSourceProperties(data: _fills));
    await controller.addLineLayer(
      "fills",
      "lines",
      LineLayerProperties(
        lineColor: Colors.indigo.toHexStringRGB(),
        lineCap: "round",
        lineJoin: "round",
        lineWidth: 3,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },

            icon: const Icon(Icons.arrow_back_ios_rounded)),

        title: const Text('Review Route'),

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent.shade100, Colors.greenAccent.shade200],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: MapboxMap(
                accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: _onStyleLoadedCallback,
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                // minMaxZoomPreference: const MinMaxZoomPreference(11, 11),
                compassEnabled: true,
              ),
            ),
            reviewRideBottomSheet(context, distance, dropOffTime),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          controller.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition));
        },
        elevation: 0,
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: Colors.redAccent.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(Icons.my_location),
        ),
        backgroundColor: Colors.blueAccent.shade200,
        foregroundColor: Colors.white,
      ),
    );
  }
}
