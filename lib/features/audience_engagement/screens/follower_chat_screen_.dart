import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:lovemug_creator/core/constants/variables.dart';
import 'package:lovemug_creator/core/pallette/pallete.dart';

class ChatPage extends StatefulWidget {
  final String followerName;

  ChatPage({required this.followerName});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  File? _image;
  final picker = ImagePicker();
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        messages.add({'type': 'image', 'data': File(pickedFile.path)});
      });
    }
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add({'type': 'text', 'data': _messageController.text});
        _messageController.clear();
      });
    }
  }

  Future<void> _recordVoice() async {
    // Voice recording feature implementation placeholder
    setState(() {
      messages.add({'type': 'voice', 'data': 'Voice message recorded'});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Chat with ${widget.followerName}',style: poppinsTextStyle(fontSize: 20,color: Colors.white,),),),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: message['type'] == 'text'
                        ? Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message['data'],
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                        : message['type'] == 'image'
                        ? Image.file(
                      message['data'],
                      height: 100,
                    )
                        : Icon(Icons.audiotrack, color: Colors.red),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: _pickImage,
                ),
                IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: _recordVoice,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(labelText: 'Type a message...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}