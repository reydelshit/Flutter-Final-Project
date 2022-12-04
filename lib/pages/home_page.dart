import 'package:flutter/material.dart';

import 'package:finalproject/pages/login_page.dart';
import 'package:finalproject/pages/logbook_page.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  var firstName = TextEditingController();
  var purpose = TextEditingController();
  var timeIn = TextEditingController();
  var timeOut = TextEditingController();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const CircleAvatar(
                backgroundImage: AssetImage(
                  "/assets/images/logo.png",
                ),
                radius: 80.0,
                backgroundColor: Colors.transparent,
              ),
              TextField(
                  controller: firstName,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    hintStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    labelStyle: TextStyle(fontSize: 13, color: Colors.white),
                  )),
              TextField(
                  controller: purpose,
                  decoration: const InputDecoration(
                    labelText: "Purpose",
                    hintStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    labelStyle: TextStyle(fontSize: 13, color: Colors.white),
                  )),
              TextField(
                  controller: timeIn,
                  decoration: const InputDecoration(
                    labelText: "Time In",
                    hintStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    labelStyle: TextStyle(fontSize: 13, color: Colors.white),
                  )),
              TextField(
                  controller: timeOut,
                  decoration: const InputDecoration(
                    labelText: "Time Out",
                    hintStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    labelStyle: TextStyle(fontSize: 13, color: Colors.white),
                  )),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                    width: 120,
                    height: 70,
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            child: const Text('Submit'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xffcd9d63),
                            ),
                            onPressed: () {
                              if (firstName.text == '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            const Text('Firstname is empty!'),
                                        backgroundColor: Colors.red,
                                        duration: const Duration(seconds: 2),
                                        action: SnackBarAction(
                                            label: 'OK', onPressed: () {})));
                              } else if (purpose.text == '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            const Text('Purpose is empty!'),
                                        backgroundColor: Colors.red,
                                        duration: const Duration(seconds: 2),
                                        action: SnackBarAction(
                                            label: 'OK', onPressed: () {})));
                              } else if (timeIn.text == '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            const Text('Time In is empty!'),
                                        backgroundColor: Colors.red,
                                        duration: const Duration(seconds: 2),
                                        action: SnackBarAction(
                                            label: 'OK', onPressed: () {})));
                              } else if (timeOut.text == '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            const Text('Time Out is empty!'),
                                        backgroundColor: Colors.red,
                                        duration: const Duration(seconds: 2),
                                        action: SnackBarAction(
                                            label: 'OK', onPressed: () {})));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: const Text(
                                        'Succesfully Created Added Your Details'),
                                    backgroundColor: Colors.green,
                                    duration: const Duration(seconds: 2),
                                    action: SnackBarAction(
                                        label: 'OK', onPressed: () {})));
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const LogBook()));
                              }
                            }))),
                SizedBox(
                    width: 120,
                    height: 70,
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            child: const Text('Cancel'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: const Color(0xffcd9d63),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage()));
                            })))
              ])
            ])));
  }
}
