import 'package:flutter/material.dart';
import 'package:locatinsharing/Navigation/screens/tbt.dart';
import 'package:locatinsharing/Navigation/ui/Ratings.dart';

import '../helper/shared_prefs.dart';
import '../screens/turn_by_turn.dart';

Widget reviewRideBottomSheet(
    BuildContext context, String distance, String dropOffTime) {
  String sourceAddress = getSourceAndDestinationPlaceText('source');
  String destinationAddress = getSourceAndDestinationPlaceText('destination');

  return Positioned(
    bottom: 0,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('$sourceAddress ➡ $destinationAddress',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.blueAccent)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    tileColor: Colors.grey[300],
                    // leading: const Image(
                    //     image: AssetImage('assets/image/sport-car.png'),
                    //     height: 50,
                    //     width: 50),
                    title: const Text('Distance',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text('$distance km'),
                    trailing: Text('$dropOffTime Arrival Time',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                ),
                ElevatedButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => TurnByTurn())),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Colors.greenAccent.shade200,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Start your Navigation now'),
                        ])),
              ]),
        ),
      ),
    ),
  );
}
