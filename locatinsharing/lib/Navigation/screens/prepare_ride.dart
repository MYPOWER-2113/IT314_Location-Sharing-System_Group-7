import 'package:flutter/material.dart';
import '../widgets/endpoints_card.dart';
import '../widgets/search_listview.dart';
import '../widgets/review_route_button.dart';


class PrepareRide extends StatefulWidget {
  const PrepareRide({Key? key}) : super(key: key);

  @override
  State<PrepareRide> createState() => _PrepareRideState();

  // Declare a static function to reference setters from children
  static _PrepareRideState? of(BuildContext context) =>
      context.findAncestorStateOfType<_PrepareRideState>();
}

class _PrepareRideState extends State<PrepareRide> {
  bool isLoading = false;
  bool isEmptyResponse = true;
  bool hasResponded = false;
  bool isResponseForDestination = false;

  String noRequest = 'Please enter an address, a place or a location to search';
  String noResponse = 'No results found for the search';

  List responses = [];
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  // Define setters to be used by children widgets
  set responsesState(List responses) {
    setState(() {
      this.responses = responses;
      hasResponded = true;
      isEmptyResponse = responses.isEmpty;
    });

    Future.delayed(
      const Duration(milliseconds: 500),
      () => setState(() {
        isLoading = false;
      }),
    );
  }

  set isLoadingState(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }

  set isResponseForDestinationState(bool isResponseForDestination) {
    setState(() {
      this.isResponseForDestination = isResponseForDestination;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_rounded)
        ),

        title: const Text('Search Place to Navigate'),

        actions: const [
          // CircleAvatar(backgroundImage: AssetImage('assets/image/person.jpg')),
        ],

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
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              endpointsCard(sourceController, destinationController),
              isLoading
                  ? const LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
              )
                  : Container(),
              isEmptyResponse
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                          child: Text(hasResponded ? noResponse : noRequest)
                      )
              )
                  : Container(),
              searchListView(responses, isResponseForDestination,destinationController, sourceController),
            ],
          ),
        ),
      ),
      floatingActionButton: reviewRideFaButton(context),
    );
  }
}
