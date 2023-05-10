import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_booking/user_navigation.dart';

import 'constants.dart';

class Payment2 extends StatefulWidget {
   Payment2({super.key, required this.id});
  String id;


  @override
  State<Payment2> createState() => _Payment2State();
}

class _Payment2State extends State<Payment2> {
Future<dynamic> getData() async {
  var data={
    "id":widget.id,
  };
  var res =await post(Uri.parse('${Con.url}price.php'),body: data);
  print(res.body);
  var r =jsonDecode(res.body);
  return r;

}  

Future<dynamic> addData() async {
   SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');
  var data={
    "id":sp,
    "transport_id":'2'
  };
  print(data);
 var res = await post(Uri.parse('${Con.url}Payment2.php'),body: data);
 print(res.body);
 var r = jsonDecode(res.body);
  Fluttertoast.showToast(msg: 'Payment2 Completed successfully...');
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return User_navigation();
                      },));
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: getData(),

          builder: (context,snap) {
             if (!snap.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('UPI ID : XXXXX010003',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

                  ],
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Amount : 1000',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

                  ],
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () {
                      addData();
                     
                     
                    }, child:  Text('Pay')),

                  ],
                )
              ],
            );
          }
        ),
      )
      
    );
  }
}