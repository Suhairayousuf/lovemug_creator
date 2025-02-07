import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovemug_creator/core/pallette/pallete.dart';
import '../../status/screen/status_post_screen.dart';
import 'add_new_post.dart';
import 'edit_post_screen.dart';

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  // Sample Static Posts (Replace with API or Firebase)
  List<Map<String, dynamic>> posts = [
    {
      "id": "1",
      "image": "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      "caption": "Enjoying a beautiful sunset 🌅",
      "liked": false, // Ensuring this key is always present
    },
    {
      "id": "2",
      "image": "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      "caption": "Just chilling with my cat 🐱",
      "liked": false,
    },
    {
      "id": "3",
      "image": "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      "caption": "Road trip adventures 🚗💨",
      // liked key was missing, causing error
    },
  ];
  void _editPost(int index, String newCaption, String newImage) {
    setState(() {
      posts[index]["caption"] = newCaption;
      posts[index]["image"] = newImage;
    });
  }
  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Post"),
          content: Text("Are you sure you want to delete this post?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  posts.removeAt(index);
                });
                Navigator.pop(context); // Close dialog after deletion

                // Show a Snackbar message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Post deleted successfully!")),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Delete", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // Toggle like status
  void _toggleLike(int index) {
    setState(() {
      posts[index]["liked"] = !(posts[index]["liked"] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Posts", style: GoogleFonts.poppins(color: Colors.white)),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Stack(
        children: [
          posts.isEmpty
              ? Center(
            child: Text(
              "No posts yet. Click + to add a new post!",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
            ),
          )
              : Padding(
            padding: EdgeInsets.all(12),
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                bool isLiked = post["liked"] ?? false; // FIX APPLIED

                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          post["image"],
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post["caption"],
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Like Button
                                IconButton(
                                  icon: Icon(
                                    isLiked ? Icons.favorite : Icons.favorite_border,
                                    color: isLiked ? Colors.red : Colors.grey,
                                    size: 28,
                                  ),
                                  onPressed: () => _toggleLike(index),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.grey),
                                      onPressed: () async {

                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditPostScreen(
                                              index: index,
                                              currentCaption: post["caption"],
                                              currentImage: post["image"],
                                            ),
                                          ),
                                        );
                                        if (result != null) {
                                          _editPost(index, result["caption"], result["image"]);
                                        }
                                      },
                                      // Implement Edit Post Logic

                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        _showDeleteConfirmationDialog(context, index);
                                      },
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StatusUpdatesScreen()),
                        );
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
                    backgroundColor: primaryColor,
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => AddPostScreen()));
                    },
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Floating Action Button for Adding a New Post
      // floatingActionButton: BounceInUp(
      //   duration: Duration(milliseconds: 1000),
      //   child:
      // ),
    );
  }
}
