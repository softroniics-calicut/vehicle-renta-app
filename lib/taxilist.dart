import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:vehicle_booking/taxiview.dart';

import 'constants.dart';

class TaxiList extends StatefulWidget {
  const TaxiList({super.key});

  @override
  State<TaxiList> createState() => _TaxiListState();
}

class _TaxiListState extends State<TaxiList> {
     Future<dynamic> getData() async {
    var response = await get(Uri.parse('${Con.url}taxilist.php'));
    var res = jsonDecode(response.body);
    print(res);
    return res;
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getData(),
        builder: (context,snap) {
           if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: snap.data.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TaxiView(id :'${snap.data[index]['transportation_id']}');
                  },));
                },
                child: ListTile(
                  title: Text('${snap.data[index]['vehicle']}'),
                  subtitle: Text('${snap.data[index]['seats']}  seats'),
                  // trailing: Text('date'),
              
                          ),
              );
            },
            
          );
        }
      ),
    );
  }
}