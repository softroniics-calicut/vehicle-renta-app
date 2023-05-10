import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vehicle_booking/autolist.dart';
import 'package:vehicle_booking/taxilist.dart';
import 'package:vehicle_booking/trucklist.dart';

import 'buslist.dart';

class Transport extends StatefulWidget {
  const Transport({super.key});

  @override
  State<Transport> createState() => _TransportState();
}

class _TransportState extends State<Transport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BusList();
              },));
            },
            child: Card(
              elevation: 4,
              child: Container(height: 80,
               width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                  color: Colors.purple,
              ),
            child: Center(child: Text('Bus',style: TextStyle(color: Colors.white,fontSize: 18))),
              ),
            ),
          ),
           InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AutoList();
              },));
            },
             child: Card(
              elevation: 4,
              child: Container(height: 80,
               width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                  color: Colors.purple,
              ),
             child: Center(child: Text('Auto',style: TextStyle(color: Colors.white,fontSize: 18))),
              ),
                     ),
           ),
          
           InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TaxiList();
              },));
            },
             child: Card(
              elevation: 4,
              child: Container(height: 80,
               width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                  color: Colors.purple,
              ),
             child: Center(child: Text('Taxi',style: TextStyle(color: Colors.white,fontSize: 18))),
              ),
                     ),
           ),
           InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TruckList();
              },));
            },
             child: Card(
              elevation: 4,
              child: Container(height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                  color: Colors.purple,
              ),
             child: Center(child: Text('Truck',style: TextStyle(color: Colors.white,fontSize: 18),)),
              ),
                     ),
           )
        ],),
      ),
    );
  }
}