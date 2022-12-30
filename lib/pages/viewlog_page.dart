import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
  final List<Log> logs = [
    Log("Ben Dover", "TO VISIT MY BROTHER", "8:00 AM", "5:00 PM"),
    Log("Jane Lalat", "TO DELIVER LUNCH", "8:00 AM", "5:00 PM"),
    Log("Alex Caruso", "TO ATTEND A MEETING", "2:00 AM", "1:00 PM"),
  ];

  var timeOut = TextEditingController();

  TimeOfDay _timeOut = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('eLogbook'),
        backgroundColor: const Color(0xffcd9d63),
      ),
      body: ListView.builder(
          itemCount: logs.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(logs[index].fullName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(logs[index].purpose),
                    Text("Time In: " + logs[index].timeIn),
                    Text("Time Out: " + logs[index].timeOut),
                  ],
                ),
                trailing: Wrap(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        var time = DateTime.now();
                        setState(() {
                          _timeOut = TimeOfDay.fromDateTime(time);
                          timeOut.text = _timeOut.format(context);
                        });
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
