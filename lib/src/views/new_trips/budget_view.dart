import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:appedejemplo/src/models/Trip.dart';

class NewTripBudegtView extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  final Trip trip;

  NewTripBudegtView({Key key, @required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create a Trip - Budget'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Finish"),
                Text("Location ${trip.title}"),
                Text("Finish ${trip.startDate}"),
                Text("Finish ${trip.endDate}"),
                RaisedButton(
                    onPressed: () async {
                      //Save data to firebase

                      await db.collection("trips").add(trip.toJson());
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Text('Finish'))
              ],
            ),
          ),
        ));
  }
}
