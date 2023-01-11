import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import '../model/printable_data.dart';
import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
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
  List<Map<String, dynamic>> logs = [];

  String fullName = ControllerDAO.fullname.text;
  String purpose = ControllerDAO.purpose.text;

  String contact = ControllerDAO.contact.text;
  String timeIn = ControllerDAO.timeIn.text;
  String timeOut = ControllerDAO.timeOut.text;
  // var timeOut = TextEditingController();

  var logBookID;

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

  Future<void> printDoc() async {
    final image = await imageFromAssetBundle(
      "assets/images/logo.png",
    );

    buildPrintableData(image) => pw.Padding(
          padding: const pw.EdgeInsets.all(25.00),
          child: pw.Column(children: [
            pw.Text("E-logbook System",
                style: pw.TextStyle(
                    fontSize: 25.00, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10.00),
            pw.Divider(),
            pw.Align(
              alignment: pw.Alignment.topRight,
              child: pw.Image(
                image,
                width: 250,
                height: 250,
              ),
            ),
            pw.ListView(children: [
              for (var i = 0; i < logs.length; i++)
                pw.Container(
                  decoration: const pw.BoxDecoration(),
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          logs[i]['fullName'],
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 18),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 8.0),
                          child: pw.Text(
                            "Purpose: " + logs[i]['purpose'],
                            style: const pw.TextStyle(fontSize: 15),
                          ),
                        ),
                        pw.Text(
                          "Contact: " + logs[i]['contact'],
                          style: const pw.TextStyle(fontSize: 15),
                        ),
                        pw.Text(
                          "Time In: " + logs[i]['timeIn'],
                          style: const pw.TextStyle(fontSize: 15),
                        ),
                        pw.Text(
                          "Time Out: " + logs[i]['timeOut'],
                          style: const pw.TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
            ])
          ]),
        );

    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableData(image);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
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

  void updLogBook(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            color: const Color(0xffcd9d63),
            height: MediaQuery.of(context).size.height,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            labelStyle:
                                TextStyle(fontSize: 13, color: Colors.white),
                            prefixIcon: Icon(Icons.person_outline_outlined)),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextField(
                        controller: ControllerDAO.purpose,
                        decoration: const InputDecoration(
                            labelText: "Purpose",
                            labelStyle:
                                TextStyle(fontSize: 13, color: Colors.white),
                            prefixIcon: Icon(Icons.numbers)),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextField(
                        controller: ControllerDAO.contact,
                        decoration: const InputDecoration(
                            labelText: "Contact",
                            labelStyle:
                                TextStyle(fontSize: 13, color: Colors.white),
                            prefixIcon: Icon(Icons.phone)),
                      ),
                      TextField(
                        controller: ControllerDAO.timeIn,
                        decoration: const InputDecoration(
                            labelText: "Time In",
                            labelStyle:
                                TextStyle(fontSize: 13, color: Colors.white),
                            prefixIcon:
                                Icon(Icons.access_time_filled_outlined)),
                      ),
                      TextField(
                        controller: ControllerDAO.timeOut,
                        decoration: const InputDecoration(
                            labelText: "Time Out",
                            labelStyle:
                                TextStyle(fontSize: 13, color: Colors.white),
                            prefixIcon:
                                Icon(Icons.access_time_filled_outlined)),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            // adjust width height elevated button
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffcd9d63),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(100, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
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
                              backgroundColor: const Color(0xffcd9d63),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(100, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            onPressed: () async {
                              if (ControllerDAO.fullname.text.isEmpty) {
                                showError('Fullname is Empty');
                              } else if (ControllerDAO.purpose.text.isEmpty) {
                                showError('Purpose is Empty');
                              } else if (ControllerDAO.contact.text.isEmpty) {
                                showError('Contact is Empty');
                              } else if (ControllerDAO.timeIn.text.isEmpty) {
                                showError('Time In is Empty');
                              } else {
                                var result = await DatabaseHelper.updateLogBook(
                                    logBookID,
                                    ControllerDAO.fullname.text,
                                    ControllerDAO.purpose.text,
                                    ControllerDAO.contact.text,
                                    ControllerDAO.timeIn.text,
                                    ControllerDAO.timeOut.text);
                                if (result == 1) {
                                  successMessage('Logbook is Updated');
                                  // resetControllers();
                                  setState(() {
                                    retrieveLogs();
                                  });
                                  Navigator.of(context).pop();
                                } else {
                                  //error message
                                  showError('Error Updating Logbook');
                                }
                              }
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

  void updateTimeOut() async {
    await DatabaseHelper.updateLogBook(
        logBookID,
        logs[logBookID]['fullName'],
        logs[logBookID]['purpose'],
        logs[logBookID]['contact'],
        logs[logBookID]['timeIn'],
        ControllerDAO.timeOut.text);
    retrieveLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          printDoc();
        },
        backgroundColor: const Color(0xffcd9d63),
        child: const Icon(Icons.print),
      ),
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
                    Text("Time Out: " +
                        (logs[index]['timeOut'] != null
                            ? logs[index]['timeOut']
                            : 'N/A'))
                  ],
                ),
                trailing: Wrap(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        logBookID = logs[index]['id'];
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
                                      ControllerDAO.timeOut.text =
                                          _timeOut.format(context);
                                    });
                                    updateTimeOut();
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
                                          ControllerDAO.timeOut.text =
                                              _timeOut.format(context);
                                          updateTimeOut();
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
                        updLogBook(context);
                        ControllerDAO.fullname.text = logs[index]['fullName'];
                        ControllerDAO.purpose.text = logs[index]['purpose'];
                        ControllerDAO.contact.text = logs[index]['contact'];
                        ControllerDAO.timeIn.text = logs[index]['timeIn'];
                        ControllerDAO.timeOut.text = logs[index]['timeOut'];
                        logBookID = logs[index]['id'];
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
