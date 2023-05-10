import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';

import 'constants.dart';

class ImageView3 extends StatefulWidget {
   ImageView3({super.key, required this.id});
   String id;
  @override
  State<ImageView3> createState() => _ImageView3State();
}

class _ImageView3State extends State<ImageView3> {
  @override
  Widget build(BuildContext context) {
     Future<dynamic> getData() async {
    var data = {"id": widget.id};
    var res = await post(Uri.parse('${Con.url}image3.php'), body: data);
    print(res.body);
    var r =jsonDecode(res.body);
    return r;
  }
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Center(
        child: FutureBuilder(
          future: getData(),
          builder: (context,snap) {
            if(!snap.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            return Container(
              height: 400,
              width: double.infinity,
              child: Image.network('${Con.img}${snap.data[0]['insurance']}'),
            );
          }
        ),
      ),
    ));
  }
}