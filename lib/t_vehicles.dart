import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_booking/t_view.dart';

import 'addtransport.dart';
import 'constants.dart';

class T_vehicles extends StatefulWidget {
  const T_vehicles({super.key});

  @override
  State<T_vehicles> createState() => _T_vehiclesState();
}

class _T_vehiclesState extends State<T_vehicles> {
  Future<dynamic> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');
    var data = {"id": sp};
    var response = await post(Uri.parse('${Con.url}t_list.php'), body: data);
    print(response.body);
    var res = jsonDecode(response.body);

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
            return Stack(
              children: [
                ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return T_View(
                                  id: '${snap.data[index]['transportation_id']}');
                            },
                          ));
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.emoji_transportation,
                            color: Colors.black,
                          ),
                          title: Text('${snap.data[index]['vehicle']}'),
                          subtitle: Text('${snap.data[index]['price']}'),
                          // trailing: Text('${snap.data[index]['date']}'),
                        ),
                      );
                    }),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Addtransport();
                                },
                              ));
                            },
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
