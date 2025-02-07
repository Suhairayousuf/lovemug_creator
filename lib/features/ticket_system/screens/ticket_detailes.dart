import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/variables.dart';
import '../../../core/pallette/pallete.dart';

class TicketDetailsScreen extends StatefulWidget {
  final Map<String, String> ticket;

  TicketDetailsScreen({required this.ticket});

  @override
  _TicketDetailsScreenState createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  List<Map<String, dynamic>> messages = [
    {"sender": "admin", "text": "Hello! How can I help you?", "time": "10:00 AM"},
  ];
  TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add({
          "sender": "user",
          "text": _messageController.text.trim(),
          "time": "Now",
        });
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("Ticket Details",style: GoogleFonts.poppins(color: Colors.white,fontSize: width*0.05)),
           backgroundColor: primaryColor,
           leading: InkWell(
           onTap: (){
    Navigator.pop(context);
    },
        child: Icon(Icons.arrow_back,color: Colors.white,)),),
      body: Column(
        children: [
          // Ticket Issue Description
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ticket ID: ${widget.ticket["id"]}", style: poppinsTextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("Issue: ${widget.ticket["title"]}", style: poppinsTextStyle(fontSize:  width*0.035)),
                  SizedBox(height: 5),
                  Text("Status: ${widget.ticket["status"]}", style: poppinsTextStyle(fontSize:width*0.03 , color: _getStatusColor(widget.ticket["status"]!))),
                ],
              ),
            ),
          ),

          Divider(),

          // Chat Section
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isUser = messages[index]["sender"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.purple : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(messages[index]["text"], style: poppinsTextStyle(color: isUser ? Colors.white : Colors.black)),
                        SizedBox(height: 3),
                        Text(messages[index]["time"], style: poppinsTextStyle(fontSize: width*0.025, color: Colors.black45)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Message Input Field
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.send, color: primaryColor),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Resolved":
        return Colors.green;
      case "In Progress":
        return Colors.orange;
      default:
        return Colors.red;
    }
  }
}
