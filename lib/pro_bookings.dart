import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_booking/t_booking.dart';

import 'constants.dart';

class Pro_booking extends StatefulWidget {
  const Pro_booking({super.key});

  @override
  State<Pro_booking> createState() => _Pro_bookingState();
}

class _Pro_bookingState extends State<Pro_booking> {
    Future<dynamic> getData() async {

        SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');
var data={
  "id":sp
};
    var response = await post(Uri.parse('${Con.url}pro_booking_r.php'),body: data);
       print(response.body);
    var res = jsonDecode(response.body);
    print(res);
    return res;
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Rental vehicle bookings'),
      ),
      body: Stack(
        children: [
 FutureBuilder(
            future: getData(),
            builder: (context, snap) {
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
                    return ListTile(
                      leading: Icon(
                        Icons.notifications,
                        color: Colors.black,
                      ),
                      title: Text('${snap.data[index]['name']}'),
                      subtitle: Text('${snap.data[index]['price']}'),
                      trailing: Text('${snap.data[index]['date']}'),
                    );
                  });
            }),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return T_booking();
                    },));
                  }, child: Text('Transaction Bookings')),
                ),
              ],
            )
        ],
      
      ),
    );
  }
}