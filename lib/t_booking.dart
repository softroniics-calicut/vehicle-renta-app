import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class T_booking extends StatefulWidget {
  const T_booking({super.key});

  @override
  State<T_booking> createState() => _T_bookingState();
}

class _T_bookingState extends State<T_booking> {
     Future<dynamic> getData() async {

        SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');
var data={
  "id":sp
};
    var response = await post(Uri.parse('${Con.url}pro_booking_t.php'),body: data);
       print(response.body);
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
                      title: Text('${snap.data[index]['vehicle']}'),
                      subtitle: Text('${snap.data[index]['price']}'),
                      trailing: Text('${snap.data[index]['date']}'),
                    );
                  });
            }),
    );
  }
}