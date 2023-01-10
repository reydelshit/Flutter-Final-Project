import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:finalproject/database/database_helper.dart';
import 'package:finalproject/model/controllers.dart';

// import 'package:finalproject/pages/login_page.dart';
// import 'package:finalproject/pages/logbook_page.dart';

// class Log {
//   String fullName;
//   String purpose;
//   String contact;
//   String timeIn;
//   String timeOut;
//   Log(this.fullName, this.purpose, this.contact, this.timeIn, this.timeOut);
// }

class ViewLogBook extends StatefulWidget {
  ViewLogBook({super.key});

  @override
  State<ViewLogBook> createState() => _ViewLogBookState();
}

class _ViewLogBookState extends State<ViewLogBook> {
  String fullName = ControllerDAO.fullname.text;
  String purpose = ControllerDAO.purpose.text;

  String contact = ControllerDAO.contact.text;
  String timeIn = ControllerDAO.timeIn.text;
  // String timeOut = ControllerDAO.timeOut.text;

  List<Map<String, dynamic>> logs = [];

  var timeOut = TextEditingController();

  TimeOfDay _timeOut = TimeOfDay.now();

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

  @override
  void initState() {
    super.initState();
    retrieveLogs();
  }

  retrieveLogs() async {
    final data = await DatabaseHelper.retrieveLogBook();
    setState(() {
      logs = data!;
    });
  }

  Future<void> updateLog(int id, String fullName, String purpose,
      String contact, String timeIn, String timeOut) async {
    final result = await DatabaseHelper.updateLogBook(
        id, fullName, purpose, contact, timeIn, timeOut);
    if (result == 0) {
      showError("Error updating log entry");
    } else {
      successMessage("Updated succesfully");
    }
  }

  Future deleteWarning(String fullname, int id) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Warning'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      const Center(),
                      const SizedBox(
                        height: 18.0,
                      ),
                      Center(
                          child: Text(
                        'Are you sure you want to remove  $fullname?',
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 20.0),
                      ))
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                      child: const Text('Delete'),
                      onPressed: () async {
                        var result = await DatabaseHelper.deleteLogBook(id);
                        if (result == 1) {
                          //Success Message
                          successMessage('Logbook Deleted');
                        } else {
                          //Error Message
                          showError('Error Deleting Logbook');
                        }
                        retrieveLogs();
                        setState(() {});
                        Navigator.of(context).pop();
                      }),
                ],
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('eLogbook'),
        backgroundColor: const Color(0xffcd9d63),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  // fetchLogBook();
                  retrieveLogs();
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: ListView.builder(
          itemCount: logs.length,
          itemBuilder: (BuildContext context, int index) {
            final test = logs[index];
            return ListTile(
                title: Text(logs[index]['fullName']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Purpose: " + logs[index]['purpose']),
                    Text("Contact: " + logs[index]['contact']),
                    Text("Time In: " + logs[index]['timeIn']),
                    Text("Time Out: " + logs[index]['timeOut']),
                  ],
                ),
                trailing: Wrap(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return CupertinoActionSheet(
                              title: const Text('Time Out'),
                              message: const Text(
                                  'Please select a time for time out.'),
                              actions: <Widget>[
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    var time = DateTime.now();
                                    setState(() {
                                      _timeOut = TimeOfDay.fromDateTime(time);
                                      timeOut.text = _timeOut.format(context);
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 100,
                                    child: CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.time,
                                      onDateTimeChanged: (time) {
                                        setState(() {
                                          _timeOut =
                                              TimeOfDay.fromDateTime(time);
                                          timeOut.text =
                                              _timeOut.format(context);
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
                      child: const Text('Time Out'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0))),
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return Container(
                                color: Colors.black,
                                height: MediaQuery.of(context).size.height,
                                child: SafeArea(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 16.0,
                                          ),
                                          TextField(
                                            controller: ControllerDAO.fullname,
                                            decoration: const InputDecoration(
                                                labelText: "Full Name",
                                                labelStyle: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                                prefixIcon: Icon(Icons
                                                    .person_outline_outlined)),
                                          ),
                                          const SizedBox(
                                            height: 16.0,
                                          ),
                                          TextField(
                                            controller: ControllerDAO.purpose,
                                            decoration: const InputDecoration(
                                                labelText: "Purpose",
                                                labelStyle: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                                prefixIcon:
                                                    Icon(Icons.numbers)),
                                          ),
                                          const SizedBox(
                                            height: 16.0,
                                          ),
                                          TextField(
                                            controller: ControllerDAO.contact,
                                            decoration: const InputDecoration(
                                                labelText: "Contact",
                                                labelStyle: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                                prefixIcon: Icon(Icons.link)),
                                          ),
                                          TextField(
                                            controller: ControllerDAO.timeIn,
                                            decoration: const InputDecoration(
                                                labelText: "Time In",
                                                labelStyle: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                                prefixIcon: Icon(Icons.link)),
                                          ),
                                          const SizedBox(height: 16.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                // adjust width height elevated button
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.green.shade700,
                                                  foregroundColor: Colors.white,
                                                  minimumSize:
                                                      const Size(100, 50),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32.0),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              const SizedBox(width: 20.0),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.green.shade700,
                                                  foregroundColor: Colors.white,
                                                  minimumSize:
                                                      const Size(100, 50),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32.0),
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  // if (fullnameController.text.isEmpty) {
                                                  //   showError('Please enter fullname');
                                                  // } else if (yearController.text.isEmpty) {
                                                  //   showError('Please enter year');
                                                  // } else if (blockController.text.isEmpty) {
                                                  //   showError('Please enter block');
                                                  // } else {
                                                  //   var result = await DatabaseHelper.insertStudent(
                                                  //       fullnameController.text,
                                                  //       yearController.text,
                                                  //       blockController.text);
                                                  //   if (result > 0) {
                                                  //     //Success Message
                                                  //     successMessage('Student Added - ADD MODAL');
                                                  //     resetControllers();
                                                  //     setState(() {
                                                  //       loadAllStudents();
                                                  //     });
                                                  //     Navigator.of(context).pop();
                                                  //   } else {
                                                  //     //Error Message
                                                  //     showError('Error Adding Student - ADD MODAL');
                                                  //   }
                                                  // }
                                                },
                                                child: const Text('Update'),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        deleteWarning(
                            logs[index]['fullName'], logs[index]['id']);
                      },
                    ),
                  ],
                ));
          }),
    );
  }
}
