import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/variables.dart';
import '../../../core/pallette/pallete.dart';
import '../../../model/user_model.dart';
import 'creators.dart';

class CreatorChatPage extends StatefulWidget {
  final User selectedUser;
  final User currentUser;
  const CreatorChatPage({super.key, required this.selectedUser, required this.currentUser});

  @override
  State<CreatorChatPage> createState() => _CreatorChatPageState();
}

class _CreatorChatPageState extends State<CreatorChatPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Message> messages = [];
  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add(Message(text: _messageController.text, sender: widget.currentUser));
      });
      _messageController.clear();
    }
  }
  void _attachFile() {
    // TODO: Implement file picker
    print("File Attachment Clicked!");
  }

  void _recordVoice() {
    // TODO: Implement voice recording
    print("Voice Recording Clicked!");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back,color: Colors.white,)
        ),

        backgroundColor: primaryColor,
        title: Row(
          children: [
            // CircleAvatar(backgroundImage: NetworkImage(widget.selectedUser.profilePic)),
            CircleAvatar(child: Icon(Icons.person,)),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.selectedUser.name, style: poppinsTextStyle(fontSize: width*0.04, fontWeight: FontWeight.bold,color: Colors.white)),
                Text(DateTime.now().toString(), style: poppinsTextStyle(fontSize: width*0.025, color: Colors.grey)),
                // Text(widget.selectedUser.time, style: poppinsTextStyle(fontSize: width*0.025, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                bool isCurrentUser = message.sender.name == widget.currentUser.name;
                return Align(
                  alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isCurrentUser ? primaryColor : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(message.text,style: GoogleFonts.poppins(color: Colors.white),),
                  ),
                );
              },
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.attach_file, color: Colors.grey),
            onPressed: _attachFile,
          ),
          IconButton(
            icon: Icon(Icons.mic, color: Colors.grey),
            onPressed: _recordVoice,
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              ),
            ),
          ),
          SizedBox(width: 5),
          CircleAvatar(
            backgroundColor: primaryColor,
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
class Message {
  final String text;
  final User sender;

  Message({required this.text, required this.sender});
}