import 'package:flutter/material.dart';

class IncomingCallScreen extends StatefulWidget {
  @override
  State<IncomingCallScreen> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://example.com/caller_avatar.jpg'), // Replace with caller's avatar URL
          ),
          SizedBox(height: 20),
          Text(
            'John Doe', // Replace with caller's name
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Incoming Call',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  // Handle call rejection
                },
                child: Icon(Icons.call_end),
                backgroundColor: Colors.red,
              ),
              FloatingActionButton(
                onPressed: () {
                  // Handle call acceptance
                },
                child: Icon(Icons.call),
                backgroundColor: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
