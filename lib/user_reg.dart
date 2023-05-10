import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:vehicle_booking/login.dart';

import 'constants.dart';

class User_reg extends StatefulWidget {
  const User_reg({super.key});

  @override
  State<User_reg> createState() => _User_regState();
}

class _User_regState extends State<User_reg> {

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

  var first = TextEditingController();
  var last= TextEditingController();
  var street = TextEditingController();
  var district = TextEditingController();
  var phn = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();

  Future<void> addData() async {
    var data = {
      "first":first.text,
      "last":last.text,
      "street":street.text,
      "district":dropdownvalue,
      "phn":phn.text,
      "email":email.text,
      "password":password.text,

    };
    var res =await post(Uri.parse('${Con.url}user_reg.php'),body: data);
    print(res.body);
    Fluttertoast.showToast(msg: 'Successfully registered...');
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Login();

    },));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text('USER REGISTRATION',style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold,fontSize: 15),),
          )),
         
           Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: first,
              decoration: InputDecoration(border: OutlineInputBorder(),  label: Text('Firstname')),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: last,
              decoration: InputDecoration(border: OutlineInputBorder(),  label: Text('Lastname')),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: street,
              decoration: InputDecoration(border: OutlineInputBorder(),  label: Text('Street')),
            ),
          ),
            Padding(
            padding: const EdgeInsets.all(18.0),
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
           Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: phn,
              decoration: InputDecoration(border: OutlineInputBorder(),  label: Text('Phone number')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(border: OutlineInputBorder(),  label: Text('Email')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: password,
              decoration: InputDecoration(border: OutlineInputBorder(),  label: Text('Password')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ElevatedButton(onPressed: (){
              addData();
                          }, child: Text('Register')),
          )
        
        ],
      ),
    );
  }
}