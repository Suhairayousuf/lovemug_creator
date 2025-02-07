import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusAnalyticsScreen extends StatefulWidget {
  final String statusImage;

  StatusAnalyticsScreen({required this.statusImage});

  @override
  _StatusAnalyticsScreenState createState() => _StatusAnalyticsScreenState();
}

class _StatusAnalyticsScreenState extends State<StatusAnalyticsScreen> {
  List<Map<String, String>> likedUsers = [
    {"name": "John Doe", "profilePic": "https://via.placeholder.com/100"},
    {"name": "Alice Smith", "profilePic": "https://via.placeholder.com/100"},
    {"name": "Michael Brown", "profilePic": "https://via.placeholder.com/100"},
  ];

  int likeCount = 3; // Example initial likes

  void _toggleLike() {
    setState(() {
      if (likeCount > 0) {
        likeCount = 0;
        likedUsers.clear();
      } else {
        likeCount = 3;
        likedUsers = [
          {"name": "John Doe", "profilePic": "https://via.placeholder.com/100"},
          {"name": "Alice Smith", "profilePic": "https://via.placeholder.com/100"},
          {"name": "Michael Brown", "profilePic": "https://via.placeholder.com/100"},
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Status Analytics"), backgroundColor: Colors.pinkAccent),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(widget.statusImage, height: 250, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Likes: $likeCount", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(likeCount > 0 ? Icons.favorite : Icons.favorite_border, color: likeCount > 0 ? Colors.red : Colors.grey),
                  onPressed: _toggleLike,
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: likedUsers.isEmpty
                  ? Center(child: Text("No likes yet.", style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey)))
                  : ListView.builder(
                itemCount: likedUsers.length,
                itemBuilder: (context, index) {
                  final user = likedUsers[index];
                  return ListTile(
                    leading: CircleAvatar(backgroundImage: NetworkImage(user["profilePic"]!)),
                    title: Text(user["name"]!, style: GoogleFonts.poppins(fontSize: 16)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
