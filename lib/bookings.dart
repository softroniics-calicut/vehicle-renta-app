import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_booking/transbookings.dart';

import 'constants.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {

    Future<dynamic> getData() async {
        SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');

      var data = {
        "id":sp,
      };
    var response = await post(Uri.parse('${Con.url}rental.php'),body: data);
    var res = jsonDecode(response.body);
    print(res);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context,snap) {
           if (!snap.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
          return Stack(
            children: [
ListView.builder(
              itemCount: snap.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('${snap.data[index]['name']}'),
                  subtitle: Text('${snap.data[index]['price']}'),
                  trailing: Text('${snap.data[index]['date']}'),
                );
              },
              
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Trans();
                    },));
                    
                  }, child: Text('Transport Bookings')),
                ],
              ),
            )
            ]
          );
          
        }
      ),
            
          
    );
  }
}