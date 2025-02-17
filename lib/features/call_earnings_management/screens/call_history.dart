// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../core/constants/variables.dart';
// import '../../../core/pallette/pallete.dart';
// import '../../home/navigation_page.dart';
//
// class CallHistoryScreen extends StatefulWidget {
//   @override
//   _CallHistoryScreenState createState() => _CallHistoryScreenState();
// }
//
// class _CallHistoryScreenState extends State<CallHistoryScreen> {
//   // Example Call History Data (Hardcoded for now)
//   List<Map<String, dynamic>> callHistory = [
//     {"creator": "John Doe", "duration": "5m 30s", "type": Icons.keyboard_voice_outlined, "date": DateTime(2024, 2, 1)},
//     {"creator": "Jane Smith", "duration": "3m 15s", "type": Icons.keyboard_voice_outlined, "date": DateTime(2024, 2, 3)},
//     {"creator": "Alice Brown", "duration": "10m 0s", "type": Icons.video_call, "date": DateTime(2024, 2, 5)},
//     {"creator": "Bob Johnson", "duration": "8m 45s", "type": Icons.keyboard_voice_outlined, "date": DateTime(2024, 2, 7)},
//     {"creator": "Emily White", "duration": "12m 30s", "type": Icons.video_call, "date": DateTime(2024, 2, 9)},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(title: Text("Call History",style: GoogleFonts.poppins(color: Colors.white),), backgroundColor: Colors.purple),
//       body: ListView.builder(
//         itemCount: callHistory.length,
//         itemBuilder: (context, index) {
//           var call = callHistory[index];
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: primaryColor,
//                 child: Icon(Icons.phone, color: Colors.white),
//               ),
//               title: Text(call["creator"], style: poppinsTextStyle(fontWeight: FontWeight.bold)),
//               subtitle: Row(
//                 children: [
//                   Icon(call["type"], color: primaryColor),  // Correct icon based on call type
//                   SizedBox(width: 8), // Spacing between icon and text
//                   Text("Duration: ${call["duration"]}",style: poppinsTextStyle(color: Colors.grey,fontSize: width*0.03),),
//                 ],
//               ),
//               trailing: Text(
//                 "${call["date"].day}-${call["date"].month}-${call["date"].year}",
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants/variables.dart';
import '../../../core/pallette/pallete.dart';

class CallHistoryScreen extends StatefulWidget {
  @override
  _CallHistoryScreenState createState() => _CallHistoryScreenState();
}

class _CallHistoryScreenState extends State<CallHistoryScreen> {
  List<Map<String, dynamic>> callHistory = [];
  bool isLoading = true;

  // API Base URL
  final String baseUrl = "https://POST/api/call-history/add";

  @override
  void initState() {
    super.initState();
    fetchCallHistory(); // Fetch call history when screen loads
  }

  /// Fetch Call History from API
  Future<void> fetchCallHistory() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/list"));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        setState(() {
          callHistory = data.map((call) {
            return {
              "creator": call["caller_id"], // Change this based on API response
              "duration": "${(call["duration"] / 60).toStringAsFixed(2)} min",
              "type": call["duration"] > 300 ? Icons.video_call : Icons.keyboard_voice_outlined,
              "date": DateTime.parse(call["created_at"]),
            };
          }).toList();
          isLoading = false;
        });
      } else {
        print("Failed to fetch call history: ${response.body}");
      }
    } catch (e) {
      print("Error fetching call history: $e");
    }
  }

  /// Add Call History (POST Request)
  Future<void> addCallHistory() async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/add"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "duration": 300,
          "user_id": "60f1b0d6c2a1f12345678901",
          "caller_id": "60f1b0d6c2a1f12345678902",
          "amount": 50.00
        }),
      );

      if (response.statusCode == 200) {
        print("Call history added successfully");
        fetchCallHistory(); // Refresh call history after adding
      } else {
        print("Failed to add call history: ${response.body}");
      }
    } catch (e) {
      print("Error adding call history: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Call History", style: GoogleFonts.poppins(color: Colors.white)), backgroundColor: Colors.purple),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loader while fetching data
          : callHistory.isEmpty
          ? Center(child: Text("No Call History Available"))
          : ListView.builder(
        itemCount: callHistory.length,
        itemBuilder: (context, index) {
          var call = callHistory[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: primaryColor,
                child: Icon(call["type"], color: Colors.white),
              ),
              title: Text(call["creator"], style: poppinsTextStyle(fontWeight: FontWeight.bold)),
              subtitle: Row(
                children: [
                  Icon(call["type"], color: primaryColor),
                  SizedBox(width: 8),
                  Text("Duration: ${call["duration"]}", style: poppinsTextStyle(color: Colors.grey)),
                ],
              ),
              trailing: Text(
                "${call["date"].day}-${call["date"].month}-${call["date"].year}",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addCallHistory,
        child: Icon(Icons.add),
        backgroundColor: primaryColor,
      ),
    );
  }
}
