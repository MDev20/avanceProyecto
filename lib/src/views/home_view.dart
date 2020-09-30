import 'package:flutter/material.dart';
import 'package:appedejemplo/src/models/Trip.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  final List<Trip> tripList = [
    Trip("New York", DateTime.now(), DateTime.now(), 500.00, 'Plane'),
    Trip("Boston", DateTime.now(), DateTime.now(), 300.00, 'Plane'),
    Trip("Washington DC", DateTime.now(), DateTime.now(), 350.00, 'Plane'),
    Trip("Austin, Texas", DateTime.now(), DateTime.now(), 250.00, 'Plane'),
    Trip("Seattle", DateTime.now(), DateTime.now(), 500.00, 'Plane'),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount: tripList.length,
          itemBuilder: (BuildContext context, int index) =>
              buildTripCard(context, index)),
    );
  }

  Widget buildTripCard(BuildContext context, int index) {
    final trip = tripList[index];
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      trip.title,
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
                child: Row(children: <Widget>[
                  Text(
                      "${DateFormat('dd/MM/yyyy').format(trip.startDate).toString()} - ${(DateFormat('dd/MM/yyyy').format(trip.endDate).toString())}"),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text("\ USD ${trip.budget.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 35.0, fontWeight: FontWeight.w300)),
                    Spacer(),
                    Text(trip.travelType),
                    Icon(Icons.airplanemode_active)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
