import 'package:appedejemplo/src/models/Trip.dart';
import 'package:appedejemplo/src/services/auth_services.dart';
import 'package:appedejemplo/src/views/home_view.dart';
import 'package:appedejemplo/src/pages.dart';
import 'package:appedejemplo/src/views/new_trips/location_view.dart';
import 'package:flutter/material.dart';
import 'package:appedejemplo/src/widgets/provider_widget.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    ExplorePage(),
    PastPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final newTrip = new Trip(null, null, null, null, null);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NewTripLocationView(trip: newTrip)));
              }),
          IconButton(
              icon: Icon(Icons.undo),
              onPressed: () async {
                try {
                  AuthService auth = Provider.of(context).auth;
                  await auth.signOut();
                  print("Cerrar Sesión");
                } catch (e) {
                  print(e);
                }
              }),
        ],
        title: Text('Travel Budget App'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore), title: Text('Explore')),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), title: Text('History')),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
