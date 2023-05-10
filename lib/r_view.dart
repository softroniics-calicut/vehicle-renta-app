import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';

import 'constants.dart';
import 'imageview.dart';
import 'imge1.dart';

class R_view extends StatefulWidget {
   R_view({super.key, required this.id});
String id;
  @override
  State<R_view> createState() => _R_viewState();
}

class _R_viewState extends State<R_view> {
   Future<dynamic> getData() async {
    var data = {
      "id":widget.id,
    };
    var res=await post(Uri.parse('${Con.url}r_view.php'),body: data);
    print(res.body);
    var result = jsonDecode(res.body);
    return result;

    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: getData(),
          builder: (context,snap) {
             if(!snap.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
             if(snap.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            return ListView(children: [
              Container(
                height: 250,
                child: Image.network(
                    '${Con.img}${snap.data[0]['upload_photo']}'),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                    child: Text(
                  '${snap.data[0]['name']}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
              ),
              Center(
                child: Text('Rs : ${snap.data[0]['price']}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
             
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('location',style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('${snap.data[0]['location']}'),
                  ],
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('No of seats',style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('${snap.data[0]['seats_of_vehicle']}'),
                  ],
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Fuel type',style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('${snap.data[0]['fuel_of_vehicle']}'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('rc',style: TextStyle(fontWeight: FontWeight.bold),),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ImageView(id:'${snap.data[0]['rental_id']}');
                        },));
                      },
                      child: Text('View')),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('insurance',style: TextStyle(fontWeight: FontWeight.bold),),
                    InkWell(
                      onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ImageView1(id:'${snap.data[0]['rental_id']}');
                        },));
                      },
                      child: Text('View')),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(18.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text('licence',style: TextStyle(fontWeight: FontWeight.bold),),
              //       Text('View'),
              //     ],
              //   ),
              // ),
             
            ]);
          }
        ),
        
      ),
    );;

  }
}