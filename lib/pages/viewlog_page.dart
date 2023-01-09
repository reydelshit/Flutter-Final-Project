import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:finalproject/database/database_helper.dart';

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

                    // HOW CAN I MAKE THOSE CONTROLLERS FROM THE OTHER FILE
                    // TO BE USED HERE?
                    // I TRIED TO USE THE SAME CONTROLLERS BUT IT DOESN'T WORK

                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // showModalBottomSheet(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return Container(
                        //       height: 200,
                        //       child: Column(
                        //         children: [
                        //           TextField(
                        //             controller: fullName,
                        //             decoration:
                        //                 InputDecoration(labelText: 'Full name'),
                        //           ),
                        //           TextField(
                        //             controller: purpose,
                        //             decoration:
                        //                 InputDecoration(labelText: 'Purpose'),
                        //           ),
                        //           TextField(
                        //             controller: contact,
                        //             decoration:
                        //                 InputDecoration(labelText: 'Contact'),
                        //           ),
                        //           TextField(
                        //             controller: timeIn,
                        //             decoration:
                        //                 InputDecoration(labelText: 'Time in'),
                        //           ),
                        //           TextField(
                        //             controller: timeOut,
                        //             decoration:
                        //                 InputDecoration(labelText: 'Time out'),
                        //           ),
                        //           ElevatedButton(
                        //             onPressed: () {
                        //               updateLog(id, fullName, purpose, contact,
                        //                   timeIn, timeOut);
                        //               Navigator.pop(context);
                        //             },
                        //             child: Text("Update"),
                        //           )
                        //         ],
                        //       ),
                        //     );
                        //   },
                        // );
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
