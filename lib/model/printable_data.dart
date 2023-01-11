import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// buildPrintableData(image) => pw.Padding(
//       padding: const pw.EdgeInsets.all(25.00),
//       child: pw.Column(children: [
//         pw.Text("E-logbook System",
//             style:
//                 pw.TextStyle(fontSize: 25.00, fontWeight: pw.FontWeight.bold)),
//         pw.SizedBox(height: 10.00),
//         pw.Divider(),
//         pw.Align(
//           alignment: pw.Alignment.topRight,
//           child: pw.Image(
//             image,
//             width: 250,
//             height: 250,
//           ),
//         ),
//         pw.ListView(
//     children: [
//        for (var i = 0; i < logs.length; i++) 
//            pw.ListTile(
//                 title: pw.Text(logs[i]['fullName']),
//                 subtitle: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text("Purpose: " + logs[i]['purpose']),
//                     pw.Text("Contact: " + logs[i]['contact']),
//                     pw.Text("Time In: " + logs[i]['timeIn']),
//                     pw.Text("Time Out: " + logs[i]['timeOut']),
//                   ],
//                 ),
               
//        ])

//       ]),
//     );
