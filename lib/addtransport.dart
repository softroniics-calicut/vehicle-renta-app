import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_booking/rcadd_t.dart';
import 'package:vehicle_booking/service.dart';

class Addtransport extends StatefulWidget {
  const Addtransport({super.key});

  @override
  State<Addtransport> createState() => _AddtransportState();
}

class _AddtransportState extends State<Addtransport> {
    XFile? pickedFile;
  File? image;

  File? pickedImage;
  String dropdownvalue = 'Kozhikode';
    var items = [
    'Kozhikode',
    'Kannur',
    'Ernakulam',
    'Kollam',
    'Palakkad',
    'Thiruvananthapuram',
    'Wayanad',
    'Alappuzha',
    'Idukki',
    'Kasaragod',
    'Kottayam',
    'Malappuram',
    'Pathanamthitta',
    'Thrissur'
  ];

  var name = TextEditingController();
  var type = TextEditingController();
  var gear = TextEditingController();
  var color = TextEditingController();
  var fuel = TextEditingController();
  var price = TextEditingController();
  var seat = TextEditingController();

   addTransport(BuildContext context) async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');
    if (pickedImage != null) {
      final data = await Services.postWithIamge(
          endPoint: 'add_transport.php',
          params: {
            'id': sp,
            "name": name.text,
            "type": type.text,
          
          
            "price": price.text,
            "district": dropdownvalue,
            "seat": seat.text
          },
          image: pickedImage!,
          imageParameter: 'photo');

      if ((data as Map)['result'] == 'done') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => Rcadd_t(),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: 'Vehicle Added...');
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Rcadd_t();
          },
        ));
      }
    } else {
      Fluttertoast.showToast(msg: 'Pick image ');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upload vehicle image',
                  style: TextStyle(fontSize: 15),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    File? temp = await Services.pickImage(context);
                    setState(() {
                      pickedImage = temp;
                    });
                    print(pickedImage!.path);
                  },
                  child: Icon(Icons.camera_alt),
                ),
                // image == null ? Text('no image') : Image.file(image!),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('Name')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                TextFormField(
                  controller: type,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text('Vehicle Type')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('*Only choose taxi,auto,bus,truck',style: TextStyle(color: Colors.red),),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: seat,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('Seats')),
            ),
          ),
         
          
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: price,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text(' Price')),
            ),
          ),
         
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: DropdownButtonFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Select your district';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Your District'),
              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(18.0),
          //   child: TextFormField(
          //     decoration: InputDecoration(border: OutlineInputBorder(),label: Text('RC')),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(18.0),
          //   child: TextFormField(
          //     decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Insurance')),
          //   ),
          // ),
 Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                addTransport(context);
              },
              child: Container(
                height: 50,
                child: Center(child: Text("ADD")),
                decoration: BoxDecoration(color: Colors.purple),
              ),
            ),
          )
         
        ],
      ),
      
    );
  }
}