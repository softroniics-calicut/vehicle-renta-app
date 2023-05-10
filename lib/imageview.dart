import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';

import 'constants.dart';

class ImageView extends StatefulWidget {
  ImageView({super.key, required this.id});
  String id;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  Future<dynamic> getData() async {
    var data = {"id": widget.id};
    var res = await post(Uri.parse('${Con.url}image.php'), body: data);
    print(res.body);
    var r =jsonDecode(res.body);
    return r;
  }

  @override
  Widget build(BuildContext context) {
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
              child: Image.network('${Con.img}${snap.data[0]['rc']}'),
            );
          }
        ),
      ),
    ));
  }
}
