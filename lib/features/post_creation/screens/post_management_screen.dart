// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:lovemug_creator/core/pallette/pallete.dart';
// import 'package:uuid/uuid.dart';
//
// class PostManagementScreen extends StatefulWidget {
//   @override
//   _PostManagementScreenState createState() => _PostManagementScreenState();
// }
//
// class _PostManagementScreenState extends State<PostManagementScreen> {
//   final TextEditingController _captionController = TextEditingController();
//   final ImagePicker _picker = ImagePicker();
//   File? _selectedImage;
//
//   List<Map<String, dynamic>> posts = []; // List to store posts
//   final Uuid uuid = Uuid(); // Unique ID generator for posts
//
//   // Pick image from gallery
//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }
//
//   // Upload post
//   void _uploadPost() {
//     if (_selectedImage == null || _captionController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please select an image and add a caption")),
//       );
//       return;
//     }
//
//     setState(() {
//       posts.insert(0, {
//         "id": uuid.v4(),
//         "image": _selectedImage,
//         "caption": _captionController.text,
//       });
//       _selectedImage = null;
//       _captionController.clear();
//     });
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Post uploaded successfully!")),
//     );
//   }
//
//   // Delete post
//   void _deletePost(String id) {
//     setState(() {
//       posts.removeWhere((post) => post["id"] == id);
//     });
//   }
//
//   // Edit post caption
//   void _editPost(String id) {
//     final post = posts.firstWhere((post) => post["id"] == id);
//     _captionController.text = post["caption"];
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Edit Post"),
//           content: TextField(
//             controller: _captionController,
//             decoration: InputDecoration(labelText: "Update Caption"),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   post["caption"] = _captionController.text;
//                 });
//                 Navigator.pop(context);
//               },
//               style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
//               child: Text("Save"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Post Management", style: GoogleFonts.poppins()),
//         centerTitle: true,
//         backgroundColor: primaryColor,
//         leading: InkWell(
//             onTap: (){
//               Navigator.pop(context);
//             },
//             child: Icon(Icons.arrow_back,color: Colors.white,)),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Image Picker & Caption Input
//             FadeInDown(
//               child: Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       GestureDetector(
//                         onTap: _pickImage,
//                         child: _selectedImage != null
//                             ? ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.file(_selectedImage!, height: 150, fit: BoxFit.cover),
//                         )
//                             : Container(
//                           height: 150,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: Colors.grey),
//                           ),
//                           child: Icon(Icons.add_photo_alternate, size: 50, color: Colors.grey),
//                         ),
//                       ),
//                       SizedBox(height: 15),
//                       TextField(
//                         controller: _captionController,
//                         decoration: InputDecoration(
//                           labelText: "Add a caption...",
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                           filled: true,
//                           fillColor: Colors.white,
//                         ),
//                       ),
//                       SizedBox(height: 15),
//                       ElevatedButton(
//                         onPressed: _uploadPost,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: primaryColor,
//                           padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                         ),
//                         child: Text("Upload Post", style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 20),
//
//             // List of Posts
//             Expanded(
//               child: posts.isEmpty
//                   ? Center(
//                 child: Text(
//                   "No posts available",
//                   style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
//                 ),
//               )
//                   : ListView.builder(
//                 itemCount: posts.length,
//                 itemBuilder: (context, index) {
//                   final post = posts[index];
//                   return FadeInUp(
//                     child: Card(
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                       margin: EdgeInsets.symmetric(vertical: 10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
//                             child: Image.file(post["image"], height: 200, width: double.infinity, fit: BoxFit.cover),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.all(12),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   post["caption"],
//                                   style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
//                                 ),
//                                 SizedBox(height: 10),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     IconButton(
//                                       icon: Icon(Icons.edit, color: Colors.blue),
//                                       onPressed: () => _editPost(post["id"]),
//                                     ),
//                                     IconButton(
//                                       icon: Icon(Icons.delete, color: Colors.red),
//                                       onPressed: () => _deletePost(post["id"]),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lovemug_creator/core/pallette/pallete.dart';

import '../../earnings/screens/earnings_summary.dart';
import '../../post_creation/screens/post_management_screen.dart';
import '../../profile/screens/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink.withOpacity(0.1), primaryColor],

                // colors: [Colors.purple, primaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Scrollable Content
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 80),

                // Animated Profile Picture
                Center(
                  child: Pulse(
                    infinite: true,
                    duration: Duration(seconds: 3),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            "https://randomuser.me/api/portraits/women/44.jpg"),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15),

                // Username
                FadeInDown(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    "Samantha Rose",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                // Status Message
                FadeInDown(
                  duration: Duration(milliseconds: 700),
                  child: Text(
                    "Living the love 💖 | Looking for my match!",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // Profile Stats - Followers, Posts, Wallet, Earnings
                FadeInLeft(
                  duration: Duration(milliseconds: 800),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      color: Colors.white.withOpacity(0.2),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStat("Followers", "12.5K"),
                            _buildStat("Posts", "325"),
                            _buildStat("Earnings", "\$1250"),
                            _buildStat("Wallet", "\$250"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Bio Section
                FadeInUp(
                  duration: Duration(milliseconds: 900),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Love exploring new places, meeting new people, and finding someone special 💕",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 50),
              ],
            ),
          ),

          // Floating Edit Profile Button
          Positioned(
            bottom: 30,
            right: 30,
            child: Row(
              children: [
                // Post Status Button
                Positioned(
                  top: 140, // Adjust based on profile picture position
                  right: MediaQuery.of(context).size.width * 0.38, // Center align near profile
                  child: BounceInUp(
                    duration: Duration(milliseconds: 1000),
                    child: GestureDetector(
                      onTap: () {
                        // Open Post Status Screen
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => PostStatusScreen()),
                        // );
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight, // Align "+" button to bottom right
                        children: [
                          // Profile Picture inside Circular Container
                          Container(
                            width: 60, // Profile picture size
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3), // White border
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.network(
                                "https://randomuser.me/api/portraits/women/44.jpg", // Replace with dynamic profile picture
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          // "+" Button Positioned on Bottom Right
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor, // Match Instagram story button color
                                border: Border.all(color: Colors.white, width: 2), // White border
                              ),
                              child: Icon(Icons.add, color: Colors.white, size: 16), // Small "+" icon
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),


                SizedBox(width: 15), // Space between buttons

                // Edit Profile Button
                BounceInUp(
                  duration: Duration(milliseconds: 1000),
                  child: FloatingActionButton(
                    heroTag: "edit", // Unique tag to avoid duplicate hero error
                    backgroundColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfileScreen()),
                      );
                    },
                    child: Icon(Icons.edit, color: primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget for profile stats
  Widget _buildStat(String title, String value) {
    return InkWell(
      onTap: (){
        if(title=='Earnings'){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>EarningsSummaryScreen()));
        }else if(title=='Posts'){
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>PostManagementScreen()));

        }
      },
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
