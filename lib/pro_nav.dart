import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vehicle_booking/bookings.dart';
import 'package:vehicle_booking/home.dart';
import 'package:vehicle_booking/notification.dart';
import 'package:vehicle_booking/pro_bookings.dart';
import 'package:vehicle_booking/pro_home.dart';

import 'noti.dart';

class Pro_nav extends StatefulWidget {
  Pro_nav({Key? key}) : super(key: key);

  @override
  _Pro_navState createState() => _Pro_navState();
}

class _Pro_navState extends State<Pro_nav> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    Notificationss(),
    Prohome(),
    Pro_booking(),
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
