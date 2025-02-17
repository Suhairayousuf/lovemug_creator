import 'package:flutter/material.dart';
import 'package:lovemug_creator/core/pallette/pallete.dart';

import '../../../core/constants/variables.dart';
import '../../../model/user_model.dart';



class BlockedUsersScreen extends StatefulWidget {
  @override
  _BlockedUsersScreenState createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  // Simulated blocked creators list (replace with actual database fetch)
  List<User> blockedUsers = [
    User(name: "John Doe", profilePic: "https://via.placeholder.com/150", id: '', email: ''),
    User(name: "Alice Smith", profilePic: "https://via.placeholder.com/150", id: '', email: ''),
    User(name: "Michael Brown", profilePic: "https://via.placeholder.com/150", id: '', email: ''),
  ];

  void _unblockUser(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Unblock User"),
          content: Text("Are you sure you want to unblock ${blockedUsers[index].name}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close the dialog
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  blockedUsers.removeAt(index);
                });
                Navigator.pop(context); // Close dialog

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("User unblocked successfully!")),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Unblock"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blocked Users",style: poppinsTextStyle(color: Colors.white,fontSize: 20),),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: blockedUsers.isEmpty
          ? Center(
        child: Text("No blocked users found",
            style: TextStyle(fontSize: 18, color: Colors.grey)),
      )
          : ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: blockedUsers.length,
        itemBuilder: (context, index) {
          final user = blockedUsers[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 5),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(""
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTecaUSem5pKm6IOdlaUjz-2XTGd5wkZnzoNQ&s"), // Replace with actual profile image
                // backgroundImage: NetworkImage(user.profilePic),
                radius: 25,
              ),
              title: Text(
                user.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              trailing: ElevatedButton(
                onPressed: () => _unblockUser(index),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Unblock", style: poppinsTextStyle(color: Colors.white)),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Model Class for User
// class User {
//   final String name;
//   final String profilePic;
//
//   User({required this.name, required this.profilePic});
// }
