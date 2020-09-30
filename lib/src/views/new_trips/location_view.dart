import 'package:appedejemplo/src/views/new_trips/date_views.dart';
import 'package:flutter/material.dart';
import 'package:appedejemplo/src/models/Trip.dart';

class NewTripLocationView extends StatelessWidget {
  final Trip trip;

  NewTripLocationView({Key key, @required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = trip.title;
    return Scaffold(
        appBar: AppBar(
          title: Text('Create a Trip'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 150.0),
              Text("Enter a Location"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _titleController,
                  autofocus: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                ),
              ),
              RaisedButton(
                  onPressed: () {
                    trip.title = _titleController.text;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewTripDateView(trip: trip)));
                  },
                  child: Text('Continue')),
              SizedBox(height: 300.0)
            ],
          ),
        ));
  }
}
