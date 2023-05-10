import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_booking/r_view.dart';

import 'addrental.dart';
import 'constants.dart';

class R_vehicles extends StatefulWidget {
  const R_vehicles({super.key});

  @override
  State<R_vehicles> createState() => _R_vehiclesState();
}

class _R_vehiclesState extends State<R_vehicles> {
    Future<dynamic> getData() async {
        SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');
      var data={
"id":sp
      };
    var response = await post(Uri.parse('${Con.url}r_list.php'),body: data);
     print(response.body);
    var res = jsonDecode(response.body);
   
    return res;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rental vehicles list'),),
      body: FutureBuilder(
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
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return R_view(id:'${snap.data[index]['rental_id']}');
                      },));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.emoji_transportation,
                        color: Colors.black,
                      ),
                      title: Text('${snap.data[index]['name']}'),
                      subtitle: Text('${snap.data[index]['price']}'),
                      // trailing: Text('${snap.data[index]['date']}'),
                    ),
                  );
                });
          }),
          floatingActionButton: FloatingActionButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddRental();
            },));
          },child: Icon(Icons.add),),
    );
  }
}