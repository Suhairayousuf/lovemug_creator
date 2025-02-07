import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovemug_creator/core/pallette/pallete.dart';

class EditPostScreen extends StatefulWidget {
  final int index;
  final String currentCaption;
  final String currentImage;

  EditPostScreen({required this.index, required this.currentCaption, required this.currentImage});

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  late TextEditingController _captionController;
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String? _newImage;

  @override
  void initState() {
    super.initState();
    _captionController = TextEditingController(text: widget.currentCaption);
    _newImage = widget.currentImage;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _newImage = pickedFile.path; // Store new image path
      });
    }
  }

  void _saveChanges() {
    Navigator.pop(context, {"caption": _captionController.text, "image": _newImage});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Post", style: GoogleFonts.poppins(color: Colors.white),

      ),
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back,color: Colors.white,)),
          centerTitle: true, backgroundColor: primaryColor),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: _selectedImage != null
                  ? ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(_selectedImage!, height: 200, fit: BoxFit.cover))
                  : ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(_newImage!, height: 200, fit: BoxFit.cover)),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _captionController,
              decoration: InputDecoration(
                labelText: "Edit caption...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12)),
              child: Text("Save Changes", style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
