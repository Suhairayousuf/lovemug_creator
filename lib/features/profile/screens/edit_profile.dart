import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image; // Store the selected image
  final picker = ImagePicker();
  final TextEditingController _nameController =
  TextEditingController(text: "Samantha Rose");
  final TextEditingController _aboutController =
  TextEditingController(text: "Love exploring new places, meeting new people, and finding someone special 💕");

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to remove an image
  void _removeImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile", style: GoogleFonts.poppins()),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture with Animation
            FadeInDown(
              duration: Duration(milliseconds: 500),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _image != null
                        ? FileImage(_image!) as ImageProvider
                        : NetworkImage(
                        "https://randomuser.me/api/portraits/women/44.jpg"),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt, color: Colors.pinkAccent),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Remove Image Option
            if (_image != null)
              TextButton(
                onPressed: _removeImage,
                child: Text("Remove Image", style: TextStyle(color: Colors.red)),
              ),

            SizedBox(height: 20),

            // Name Input Field
            FadeInLeft(
              duration: Duration(milliseconds: 700),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  prefixIcon: Icon(Icons.person, color: Colors.pinkAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 20),

            // About Me Input Field
            FadeInRight(
              duration: Duration(milliseconds: 900),
              child: TextField(
                controller: _aboutController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "About Me",
                  prefixIcon: Icon(Icons.info, color: Colors.pinkAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 40),

            // Save Button with Animation
            BounceInUp(
              duration: Duration(milliseconds: 1000),
              child: ElevatedButton(
                onPressed: () {
                  // Save Logic Here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Profile Updated Successfully!")),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Save",
                  style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
