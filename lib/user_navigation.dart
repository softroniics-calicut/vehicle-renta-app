import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vehicle_booking/bookings.dart';
import 'package:vehicle_booking/home.dart';
import 'package:vehicle_booking/notification.dart';

class User_navigation extends StatefulWidget {
  User_navigation({Key? key}) : super(key: key);

  @override
  _User_navigationState createState() => _User_navigationState();
}

class _User_navigationState extends State<User_navigation> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    Notifications(),
    Home_user(),
    Bookings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifications',
                backgroundColor:Colors.purple),
            BottomNavigationBarItem(
                icon: Icon(Icons.emoji_transportation_outlined),
                label: 'Vehicles',
                backgroundColor:Colors.purple),
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: 'Bookings',
              backgroundColor:Colors.purple,),
            
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
