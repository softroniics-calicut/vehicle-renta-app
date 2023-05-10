import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vehicle_booking/rentaltype.dart';
import 'package:vehicle_booking/transport.dart';

class Home_user extends StatefulWidget {
  const Home_user({super.key});

  @override
  State<Home_user> createState() => _Home_userState();
}

class _Home_userState extends State<Home_user> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Rental_type();
                        },
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromARGB(255, 113, 59, 122),
                      ),
                      height: 40,
                      child: Center(
                          child: Text(
                        'For Rental',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  )),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Transport();
                        },
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromARGB(255, 113, 59, 122),
                      ),
                      height: 40,
                      child: Center(
                          child: Text(
                        'Transportation',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ))
                ]),
          ),
        ],
      ),
    );
  }
}
