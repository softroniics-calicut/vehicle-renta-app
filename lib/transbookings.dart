import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class Trans extends StatefulWidget {
  const Trans({super.key});

  @override
  State<Trans> createState() => _TransState();
}

class _TransState extends State<Trans> {
  
    Future<dynamic> getData() async {
        SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');

      var data = {
        "id":sp,
      };
    var response = await post(Uri.parse('${Con.url}trans.php'),body: data);
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
                  leading: Icon(Icons.book_online),
                  title: Text('${snap.data[index]['name']}'),
                  subtitle: Text('${snap.data[index]['price']}'),
                  trailing: Text('${snap.data[index]['date']}'),
                );
              },
              
            ),
           
            ]
          );
          
        }
      ),
            
          
    );
  }
}