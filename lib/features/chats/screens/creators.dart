import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/variables.dart';
import '../../../core/pallette/pallete.dart';
import '../../../model/user_model.dart';
import 'creator_chat_page.dart';

class FollowerListWidget extends StatefulWidget {
  const FollowerListWidget({super.key});

  @override
  State<FollowerListWidget> createState() => _FollowerListWidgetState();
}

class _FollowerListWidgetState extends State<FollowerListWidget> {
  final List<User> users = [
    User(name: "Susu", profilePic: "https://via.placeholder.com/150",id:"1", email: ''),
    User(name: "John Doe", profilePic: "https://via.placeholder.com/150", id:"2", email: ''),
    User(name: "Alice", profilePic: "https://via.placeholder.com/150",id:"3", email: ''),
  ];
  final User currentUser = User(name: "Creator", profilePic: "https://via.placeholder.com/150", id: '', email: '');

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(

      appBar: AppBar(
         // automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        leading: InkWell(onTap: (){

            Navigator.pop(context);
          },

            child: Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text('FOLLOWERS LIST',style: poppinsTextStyle(color: Colors.white,fontSize: 20),),

      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatorChatPage(selectedUser: user,currentUser:currentUser),
                ),
              );
            },
            child: Card(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: width * 0.018, horizontal: width * 0.03), // Adjust padding as needed
                child: Column(
                  children: [
                    // SizedBox(height: width * 0.01,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out widgets
                      crossAxisAlignment: CrossAxisAlignment.center, // Align items in the center vertically
                      children: [
                        // Leading widget
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.person, color: Colors.white, size: width * 0.08),
                        ),
                        SizedBox(width: width * 0.03), // Space between leading and title

                        // Title and Subtitle
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                            children: [
                              Text(
                                user.name.toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: width * 0.036,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'message',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: width * 0.03,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),

                            ],
                          ),
                        ),
                        Text(DateTime.now().toString(),style:poppinsTextStyle(fontSize: 13,color: Colors.grey)),

                        // Trailing Actions

                      ],
                    ),
                    SizedBox(height: width * 0.023), // Space between items
                    // Divider(color: Colors.grey.shade300), // Add divider
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
// class User {
//   final String name;
//   final String profilePic;
//   final String time;
//   final String id;
//
//   User( {required this.name, required this.profilePic, required this.time,required this.id,});
// }




// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
//
// import '../../../core/constants/variables.dart';
// import '../../../core/pallette/pallete.dart';
// import '../../../model/user_model.dart';
// import 'creator_chat_page.dart';
//
// class FollowerListWidget extends StatefulWidget {
//   const FollowerListWidget({super.key});
//
//   @override
//   State<FollowerListWidget> createState() => _FollowerListWidgetState();
// }
//
// class _FollowerListWidgetState extends State<FollowerListWidget> {
//   late Future<List<User>> _followersFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _followersFuture = fetchFollowers();
//   }
//
//   Future<List<User>> fetchFollowers() async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://yourapi.com/api/followers/:user_id'),
//         headers: {'Accept': 'application/json'},
//       );
//
//       if (response.statusCode == 200) {
//         List<dynamic> data = jsonDecode(response.body);
//         return data.map((item) => User(
//           name: item['name'] ?? 'Unknown',
//           profilePic: item['profilePic'] ?? '',
//           id: item['id'] ?? '',
//           email: item['email'] ?? '',
//         )).toList();
//       } else {
//         throw Exception('Failed to load followers');
//       }
//     } catch (e) {
//       print('Error fetching followers: $e');
//       throw Exception('Error fetching followers');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primaryColor,
//         leading: InkWell(
//           onTap: () => Navigator.pop(context),
//           child: Icon(Icons.arrow_back, color: Colors.white),
//         ),
//         title: Text(
//           'FOLLOWERS LIST',
//           style: poppinsTextStyle(color: Colors.white, fontSize: 20),
//         ),
//       ),
//       body: FutureBuilder<List<User>>(
//         future: _followersFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Failed to load followers.'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No followers found.'));
//           }
//
//           List<User> users = snapshot.data!;
//
//           return ListView.builder(
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               final user = users[index];
//               return InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => CreatorChatPage(selectedUser: user, currentUser: User(name: "Creator", profilePic: "https://via.placeholder.com/150", id: '', email: '')),
//                     ),
//                   );
//                 },
//                 child: Card(
//                   child: Container(
//                     color: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: width * 0.018, horizontal: width * 0.03),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             CircleAvatar(
//                               radius: 22,
//                               backgroundColor: Colors.black,
//                               child: Icon(Icons.person, color: Colors.white, size: width * 0.08),
//                             ),
//                             SizedBox(width: width * 0.03),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     user.name,
//                                     style: GoogleFonts.poppins(
//                                       color: Colors.black,
//                                       fontSize: width * 0.036,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     'message',
//                                     style: GoogleFonts.poppins(
//                                       color: Colors.black,
//                                       fontSize: width * 0.03,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Text(DateTime.now().toString(), style: poppinsTextStyle(fontSize: 13, color: Colors.grey)),
//                           ],
//                         ),
//                         SizedBox(height: width * 0.023),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
