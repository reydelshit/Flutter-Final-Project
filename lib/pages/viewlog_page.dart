import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:finalproject/database/database_helper.dart';

// import 'package:finalproject/pages/login_page.dart';
// import 'package:finalproject/pages/logbook_page.dart';

class Log {
  String fullName;
  String purpose;
  String timeIn;
  String timeOut;
  Log(this.fullName, this.purpose, this.timeIn, this.timeOut);
}

class ViewLogBook extends StatefulWidget {
  ViewLogBook({super.key});

  @override
  State<ViewLogBook> createState() => _ViewLogBookState();
}

class _ViewLogBookState extends State<ViewLogBook> {
  List<Log> logs = [
    Log("Ben Dover", "TO VISIT MY BROTHER", "8:00 AM", "5:00 PM"),
    Log("Jane Lalat", "TO DELIVER LUNCH", "8:00 AM", "5:00 PM"),
    Log("Alex Caruso", "TO ATTEND A MEETING", "2:00 AM", "1:00 PM"),
  ];

  // List<Map<String, dynamic>> logs = [];

  var timeOut = TextEditingController();

  TimeOfDay _timeOut = TimeOfDay.now();

  // @override
  // void initState() {
  //   fetchLogBook();
  //   super.initState();
  // }

  // fetchLogBook() async {
  //   final data = await DatabaseHelper.retrieveLogBook();
  //   setState(() {
  //     logs = data!;
  //   });
  // }

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
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: ListView.builder(
          itemCount: logs.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(logs[index].fullName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(logs[index].timeIn),
                    Text("Time In: " + logs[index].timeIn),
                    Text("Time Out: " + logs[index].timeOut),
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
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ],
                ));
          }),
    );
  }
}
