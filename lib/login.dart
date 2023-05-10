import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_booking/pro_home.dart';
import 'package:vehicle_booking/pro_nav.dart';
import 'package:vehicle_booking/provider_reg.dart';
import 'package:vehicle_booking/user_navigation.dart';
import 'package:vehicle_booking/user_reg.dart';

import 'constants.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var user = TextEditingController();
  var pass = TextEditingController();
  Future<void> getData() async {
    var data ={
      "user":user.text,
      "pass":pass.text
    };
    var response = await post(Uri.parse('${Con.url}login.php'),body: data);
    print(response.body);
    var res = jsonDecode(response.body);
    if(res['message']=='login'){
if(res['type']=='user'){
  var id = res["log_id"];
      
      final spref = await SharedPreferences.getInstance();
      spref.setString('log_id', id);
      

      Fluttertoast.showToast(msg: 'Successfully login');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return User_navigation();
      },));
}
if(res['type']=='provider'){
  var id = res["log_id"];
      
      final spref = await SharedPreferences.getInstance();
      spref.setString('log_id', id);
      

      Fluttertoast.showToast(msg: 'Successfully login');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Pro_nav();
      },));
}
     
     
    }
    else{
      Fluttertoast.showToast(msg: 'Invalid username or password');
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: TextFormField(
            controller: user,
            decoration: InputDecoration(border: OutlineInputBorder(),labelText: 'email'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: TextFormField(
            controller: pass,
            decoration: InputDecoration(border: OutlineInputBorder(),labelText: 'password'),
        
          ),
        ),

        InkWell(
          onTap: () {
            //  Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return User_navigation();
            // },));
            getData();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
               color: Colors.purple,
            ),
            height: 40,
            width: 150,
           
            child: Center(child: Text('Login',style: TextStyle(color: Colors.white),)),
          ),
          
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Register as '),
               InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return User_reg();
                  },));
                },
                child: Text('User? ',style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold),)),
                Text('OR '),
                InkWell(
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Provider_reg();
                  },));
                  },
                  child: Text('Provider?',style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold))),
            ],
          ),
        )
      ]),
    );
  }
}