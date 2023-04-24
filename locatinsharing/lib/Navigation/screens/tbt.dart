import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:locatinsharing/Navigation/helper/shared_prefs.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class NavigationPage extends StatefulWidget {
  final LatLng destination;

  NavigationPage({required this.destination});

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  // late CameraPosition _initialCameraPostion;
  LatLng source = getTripLatLngFromSharedPrefs('source');
  LatLng destination = getTripLatLngFromSharedPrefs('destination');
  late MapboxMapController _controller ;
  late WayPoint sourceWaypoint, destinationWaypoint;
  var wayPoints = <WayPoint>[];


  late MapboxMapController controller;
  // final MapboxMapController _mapController = MapboxMapController(
  //     mapboxGlPlatform: mapboxGlPlatform,
  //     initialCameraPosition: _initialCameraPostion,
  //     annotationOrder: annotationOrder,
  //     annotationConsumeTapEvents: annotationConsumeTapEvents);
  late MapBoxNavigation _navigation;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();

    // Initialize the MapboxNavigation instance with your Mapbox access token
    _navigation = MapBoxNavigation(onRouteEvent: _onRouteEvent);
    // _navigation = MapBoxOptions();
    // _navigation.configure(
    //   voiceUnits: VoiceUnits.imperial,
    //   distanceAheadInstructionThreshold: 80,
    //   enableReroutes: true,
    //   directionsProfile: DirectionsProfile.drivingWithTraffic,
    // );
  }

  @override
  void dispose() {
    _navigation.finishNavigation();
    // _navigation.finish();
    super.dispose();
  }

  void _onRouteEvent(RouteEvent event) {
    // Handle route events, such as arrival at destination or rerouting
    // event.eventType = MapBoxEvent.progress_change;
    // event.eventType = MapBoxEvent.route_build_cancelled;
    // event.eventType = MapBoxEvent.route_built;
    // event.eventType = MapBoxEvent.navigation_running;

    if (event.eventType == MapBoxEvent.progress_change) {
      print('Progress change: ${event.data}');
    } else if (event.eventType == MapBoxEvent.route_built) {
      print('Route complete');
    } else if (event.eventType == MapBoxEvent.route_build_cancelled) {
      print('Route cancelled');
    } else if (event.eventType == MapBoxEvent.navigation_running) {
      setState(() {
        _isNavigating = true;
      });
      print('Navigation running');
    } else if (event.eventType == MapBoxEvent.navigation_finished) {
      setState(() {
        _isNavigating = false;
      });
      print('Navigation finished');
    }
  }

  void _startNavigation() async {
    // Start the navigation to the destination
    // final route = await _navigation.getRoute(origin: LatLng(0, 0), destination: widget.destination);
    // _navigation.startNavigation(route: route);
    // _navigation.startNavigation(wayPoints: wayPoints, options: options)
    MapBoxOptions options=MapBoxOptions(
      initialLongitude: source.longitude,
      initialLatitude: source.latitude,
      zoom: 14.0,
      tilt: 0.0,
      bearing: 0.0,
      enableRefresh: true,
      alternatives: true,
      voiceInstructionsEnabled: true,
      bannerInstructionsEnabled: true,
      allowsUTurnAtWayPoints: true,
      mode: MapBoxNavigationMode.drivingWithTraffic,
    );
    sourceWaypoint = WayPoint(
        name: "Source", latitude: source.latitude, longitude: source.longitude);
    destinationWaypoint = WayPoint(
        name: "Destination",
        latitude: destination.latitude,
        longitude: destination.longitude);
    wayPoints.add(sourceWaypoint);
    wayPoints.add(destinationWaypoint);

    await _navigation.startNavigation(wayPoints: wayPoints, options: options);
  }

  void _stopNavigation() async {
    // Stop the navigation
    // await _navigation.finish();
    await _navigation.finishNavigation();
  }

  _onMapCreated(MapboxMapController controller){
    this.controller=controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation'),
      ),
      body: Stack(
        children: [
          MapboxMap(
            accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: widget.destination, zoom: 14),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              children: [
                ElevatedButton(
                  child: Text(_isNavigating ? 'Stop Navigation' : 'Start Navigation'),
                  onPressed: _isNavigating ? _stopNavigation : _startNavigation,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}