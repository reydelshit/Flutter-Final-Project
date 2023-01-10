import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/constant/app_constant.dart';

import 'package:finalproject/database/database_helper.dart';
import 'package:finalproject/model/controllers.dart';

class LogBook extends StatefulWidget {
  LogBook({super.key});

  @override
  State<LogBook> createState() => _LogBookState();
}

class ControllerDAO {
  static final fullname = TextEditingController();
  static final purpose = TextEditingController();
  static final contact = TextEditingController();
  static final timeIn = TextEditingController();
  static final timeOut = TextEditingController();
}

class _LogBookState extends State<LogBook> {
  // final fullname = TextEditingController();
  // final purpose = TextEditingController();
  // final contact = TextEditingController();

  // final timeOut = TextEditingController();
  // final timeIn = TextEditingController();

  // final ControllerDAO controllerDAO = ControllerDAO();

  TimeOfDay _timeIn = TimeOfDay.now();

//  ControllerDAO(fullName, purpose, contact, timeIn, timeOut);
  // TimeOfDay _timeOut = TimeOfDay.now();
  // TextEditingController timeOut = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void showError(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
          action: SnackBarAction(label: 'OK', onPressed: () {})));
    }

    void successMessage(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
          action: SnackBarAction(label: 'OK', onPressed: () {})));
    }

    void _saveLogBook() async {
      // Create an instance of the DatabaseHelper class
      // final dbHelper = DatabaseHelper();

      // Insert a row into the logbook table
      final id = await DatabaseHelper.insertLogBook(
        ControllerDAO.fullname.text,
        ControllerDAO.purpose.text,
        // int.parse(contact.text),
        ControllerDAO.contact.text,
        ControllerDAO.timeIn.text,
        ControllerDAO.timeOut.text,
      );

      // Display a success message
      successMessage('Logbook saved with ID: $id');
    }

    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/logo.png"),
                  radius: 80.0,
                  backgroundColor: Colors.transparent,
                ),
              ),
              TextField(
                  controller: ControllerDAO.fullname,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    hintStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    labelStyle: TextStyle(fontSize: 13, color: Colors.white),
                  )),
              TextField(
                  controller: ControllerDAO.purpose,
                  decoration: const InputDecoration(
                    labelText: "Purpose",
                    hintStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    labelStyle: TextStyle(fontSize: 13, color: Colors.white),
                  )),
              TextField(
                  controller: ControllerDAO.contact,
                  decoration: const InputDecoration(
                    labelText: "Contact Number",
                    hintStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    labelStyle: TextStyle(fontSize: 13, color: Colors.white),
                  )),
              const SizedBox(height: 20),
              SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return CupertinoActionSheet(
                          title: const Text('Time In'),
                          message:
                              const Text('Please select a time for time in'),
                          actions: <Widget>[
                            CupertinoActionSheetAction(
                              onPressed: () {
                                var time = DateTime.now();
                                setState(() {
                                  _timeIn = TimeOfDay.fromDateTime(time);
                                  ControllerDAO.timeIn.text =
                                      _timeIn.format(context);
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 100,
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.time,
                                  onDateTimeChanged: (time) {
                                    setState(() {
                                      _timeIn = TimeOfDay.fromDateTime(time);
                                      ControllerDAO.timeIn.text =
                                          _timeIn.format(context);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xffcd9d63),
                  ),
                  child: const Text('Time In'),
                ),
              ),
              const SizedBox(height: 60),
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
                            onPressed: () async {
                              if (ControllerDAO.fullname.text == '') {
                                showError('Fullname is Empty');
                              } else if (ControllerDAO.purpose.text == '') {
                                showError('Purpose is Empty');
                              } else if (ControllerDAO.timeIn.text == '') {
                                showError('Time In is Empty');
                              } else {
                                _saveLogBook();
                                Navigator.pushNamed(
                                    context, AppConstants.viewLogPageRoute);
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
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xffcd9d63),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppConstants.mainPageRoute);
                            })))
              ])
            ])));
  }
}
