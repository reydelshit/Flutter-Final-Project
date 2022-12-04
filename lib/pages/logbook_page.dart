import 'package:flutter/material.dart';

// import 'package:finalproject/pages/login_page.dart';
// import 'package:finalproject/pages/logbook_page.dart';

// ignore: must_be_immutable
class LogBook extends StatelessWidget {
  const LogBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('eLogbook'),
          backgroundColor: const Color(0xffcd9d63),
        ),
        body: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
          DataTable(
            columns: const [
              DataColumn(
                  label: Text('ID',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Name',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Time In',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Time Out',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Purpose',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ],
            rows: [
              const DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('BEN DOVER')),
                DataCell(Text('9:00 AM')),
                DataCell(Text('10: 00 AM')),
                DataCell(Text('TO VISIT MY FRIEND')),
              ]),
              const DataRow(cells: [
                DataCell(Text('5')),
                DataCell(Text('ALEX CARUSO')),
                DataCell(Text('4:00 PM')),
                DataCell(Text('4:20 PM')),
                DataCell(Text('TO DELIVER LUNCH')),
              ]),
            ],
          ),
        ]));
  }
}
