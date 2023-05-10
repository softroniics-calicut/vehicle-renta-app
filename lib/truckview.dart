import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_booking/payment2.dart';
import 'package:vehicle_booking/payment3.dart';

import 'constants.dart';

class TruckView extends StatefulWidget {
   TruckView({super.key, required this.id});
String id;
  @override
  State<TruckView> createState() => _TruckViewState();
}

class _TruckViewState extends State<TruckView> {
    Future<dynamic> getData() async {
    var data = {
      "id": widget.id,
    };
    var res = await post(Uri.parse('${Con.url}truck-view.php'), body: data);
    print(res.body);
    var result = jsonDecode(res.body);
    return result;
  }

      Future<void> addBook() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');
    var data={
      "id":sp,
      "t_id":widget.id,
    };
    var rs = await post(Uri.parse('${Con.url}truck-booking.php'),body: data);
    print(rs.body);
    var ras = jsonDecode(rs.body);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Payment3(id:'${ras['price']}');
    },));
  }
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: getData(),
            builder: (context, snap) {
              if (!snap.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(children: [
                Container(
                  height: 250,
                  child: Image.network(
                      'https://res.cloudinary.com/dtptf8xuw/image/fetch/c_scale,q_30,w_350,f_auto/l_text:Arial_20_bold:TrucksBuses.com,x_70,y_100,co_rgb:ffffff/https://www.trucksbuses.com/uploads/7205_93197b9416a74889974e86796cdd4151bajaj-maxima-z-diesel.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                      child: Text(
                    'truck name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                ),
                Center(
                  child: Text('Rs : ${snap.data[0]['price']}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),

                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'capacity',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${snap.data[0]['capacity']}'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fuel type',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${snap.data[0]['fuel_type']}'),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'rc',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('View'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'insurance',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('View'),
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
                InkWell(
                  onTap: () {
                    addBook();
                  },
                  child: Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        'Book',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(color: Colors.purple),
                  ),
                )
              ]);
            }),
      ),
    );
  }
}