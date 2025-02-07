import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovemug_creator/features/ticket_system/screens/ticket_detailes.dart';

import '../../../../core/constants/variables.dart';
import '../../../core/pallette/pallete.dart';

class TicketHistoryScreen extends StatefulWidget {
  @override
  _TicketHistoryScreenState createState() => _TicketHistoryScreenState();
}

class _TicketHistoryScreenState extends State<TicketHistoryScreen> {
  List<Map<String, String>> tickets = [
    {"id": "12345", "title": "Talktime Transaction Issue", "status": "Pending"},
    {"id": "12346", "title": "Report a Creator", "status": "Resolved"},
    {"id": "12347", "title": "Other Issue", "status": "In Progress"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ticket History",style: GoogleFonts.poppins(color: Colors.white,fontSize: width*0.05),),
        backgroundColor: primaryColor,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: tickets.isEmpty
          ? Center(child: Text("No tickets found. Raise a new ticket!", style: poppinsTextStyle(fontSize: 16)))
          : ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  TicketDetailsScreen(
                      ticket: tickets[index]
                  ),  // Second tab
              ));

            },
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                leading: Icon(Icons.confirmation_number, color: primaryColor),
                title: Text(tickets[index]["title"]!, style: poppinsTextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("Status: ${tickets[index]["status"]}"),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _showNewTicketDialog(context);
        },
      ),
    );
  }

  void _showNewTicketDialog(BuildContext context) {
    String? selectedCategory;
    TextEditingController issueController = TextEditingController();
    List<String> categories = ["Talktime Transaction Problem", "Report a Creator", "Others"];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Raise a New Ticket"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity, // Ensures the dropdown takes full width
                child: DropdownButtonFormField<String>(
                  isExpanded: true, // Prevents dropdown text from overflowing
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Category",
                  ),
                  items: categories.map((category) {
                    return DropdownMenuItem(value: category, child: Text(category));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),
              ),

              SizedBox(height: 10),
              TextField(
                controller: issueController,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Describe Your Issue"),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                if (selectedCategory != null && issueController.text.isNotEmpty) {
                  setState(() {
                    tickets.add({
                      "id": "${tickets.length + 12345}",
                      "title": selectedCategory!,
                      "status": "Pending",
                    });
                  });
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              child: Text("Submit", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
