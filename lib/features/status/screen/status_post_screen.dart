import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusUpdatesScreen extends StatefulWidget {
  @override
  _StatusUpdatesScreenState createState() => _StatusUpdatesScreenState();
}

class _StatusUpdatesScreenState extends State<StatusUpdatesScreen> {
  List<Map<String, dynamic>> statuses = [];


  void _addNewStatus(Map<String, dynamic> newStatus) {
    setState(() {
      statuses.add(newStatus);
    });
  }

  Future<void> _postStatus() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return PostStatus(
          addStatusCallback: _addNewStatus,
        );
      },
    );
  }



  void _toggleLike(int index) {
    setState(() {
      if (!statuses[index]["likedBy"].contains("You")) {
        statuses[index]["likes"] += 1;
        statuses[index]["likedBy"].add("You");
      } else {
        statuses[index]["likes"] -= 1;
        statuses[index]["likedBy"].remove("You");
      }
    });
  }

  void _viewAnalytics(int index) {
    // Retrieve the 'viewedBy' list; if null, assign an empty list
    List<String> viewedBy = (statuses[index]["viewedBy"] as List<dynamic>?)?.cast<String>() ?? [];

    // Retrieve the 'likedBy' list; if null, assign an empty list
    List<String> likedBy = (statuses[index]["likedBy"] as List<dynamic>?)?.cast<String>() ?? [];

    // Rest of your code remains unchanged
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 400,
          child: Column(
            children: [
              Text(
                "Viewers",
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Divider(),
              viewedBy.isEmpty
                  ? Text("No views yet.", style: GoogleFonts.poppins(fontSize: 16))
                  : Expanded(
                child: ListView.builder(
                  itemCount: viewedBy.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://randomuser.me/api/portraits/men/${i + 10}.jpg"),
                      ),
                      title: Text(viewedBy[i], style: GoogleFonts.poppins()),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Likes",
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Divider(),
              likedBy.isEmpty
                  ? Text("No likes yet.", style: GoogleFonts.poppins(fontSize: 16))
                  : Expanded(
                child: ListView.builder(
                  itemCount: likedBy.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://randomuser.me/api/portraits/women/${i + 10}.jpg"),
                      ),
                      title: Text(likedBy[i], style: GoogleFonts.poppins()),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  void _deleteStatus(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Status'),
          content: Text('Are you sure you want to delete this status?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                setState(() {
                  statuses.removeAt(index);
                });
                Navigator.of(context).pop();
              },
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
        title: Text("Status Updates", style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.add_a_photo, color: Colors.white),
            onPressed: _postStatus,
            // onPressed: _addStatus,
          ),
        ],
      ),
      body: statuses.isEmpty
          ? Center(
        child: Text(
          "No status posted yet.\nClick on '+' to post one!",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: statuses.length,
        itemBuilder: (context, index) {
          final status = statuses[index];
          return Card(
            margin: EdgeInsets.all(12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.file(status["image"], height: 200, width: double.infinity, fit: BoxFit.cover),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        status["description"] ?? '',
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  status["likedBy"].contains("You") ? Icons.favorite : Icons.favorite_border,
                                  color: status["likedBy"].contains("You") ? Colors.red : Colors.grey,
                                ),
                                onPressed: () => _toggleLike(index),
                              ),
                              Text(
                                "${status["likes"]} Likes",
                                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              _viewAnalytics(index);
                            },
                            child: Icon(Icons.remove_red_eye),
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
    );
  }
}
class PostStatus extends StatefulWidget {
  final Function(Map<String, dynamic>) addStatusCallback;

  const PostStatus({Key? key, required this.addStatusCallback}) : super(key: key);

  @override
  _PostStatusState createState() => _PostStatusState();
}

class _PostStatusState extends State<PostStatus> {
  File? selectedImage;
  TextEditingController descriptionController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        'Add New Status',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.photo_library),
                            title: Text('Gallery'),
                            onTap: () {
                              Navigator.of(context).pop();
                              _pickImage(ImageSource.gallery);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.camera_alt),
                            title: Text('Camera'),
                            onTap: () {
                              Navigator.of(context).pop();
                              _pickImage(ImageSource.camera);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  image: selectedImage != null
                      ? DecorationImage(
                    image: FileImage(selectedImage!),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: selectedImage == null
                    ? Center(
                  child: Icon(
                    Icons.add_a_photo,
                    color: Colors.grey[800],
                    size: 50,
                  ),
                )
                    : null,
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Upload'),
          onPressed: () {
            if (selectedImage != null) {
              final newStatus = {
                "image": selectedImage!,
                "description": descriptionController.text,
                "timestamp": DateTime.now(),
                "likes": 0,
                "likedBy": [],
              };
              widget.addStatusCallback(newStatus);
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please select an image.'),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

