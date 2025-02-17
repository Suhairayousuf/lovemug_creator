// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:lottie/lottie.dart';
// import 'package:lovemug_creator/features/home/navigation_page.dart';
//
// class GoogleSignInPage extends StatefulWidget {
//   @override
//   _GoogleSignInPageState createState() => _GoogleSignInPageState();
// }
//
// class _GoogleSignInPageState extends State<GoogleSignInPage> {
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     clientId: "YOUR_WEB_CLIENT_ID_HERE", // Use Web Client ID from Google Cloud
//     scopes: ['email'],
//   );
//
//   bool _isSigningIn = false;
//
//   Future<void> _handleSignIn() async {
//     setState(() => _isSigningIn = true);
//
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         setState(() => _isSigningIn = false);
//         return; // User canceled sign-in
//       }
//
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       final String? idToken = googleAuth.idToken;
//
//       if (idToken != null) {
//
//         await _sendToServer(idToken, googleUser.displayName ?? "", googleUser.email,);
//       }
//     } catch (error) {
//       print('Sign-in failed: $error');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Sign-in failed: $error')),
//       );
//     }
//
//     setState(() => _isSigningIn = false);
//   }
//
//   Future<void> _sendToServer(String idToken, String name, String email) async {
//     const String apiUrl = "https://POST/api/auth/google"; // Replace with your backend API URL
//
//     final response = await http.post(Uri.parse(apiUrl),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "idToken": idToken,
//         "name": name,
//         "email": email,
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       print("Response: ${data['message']}");
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(data['message'])),
//       );
//
//       if (data['message'] == 'User registered successfully') {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => NavigationBarPage(userId: idToken,)),
//         );
//       }
//     } else {
//       print("Failed to register user: ${response.body}");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Failed to register user")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Lottie.asset(
//               'assets/images/Animation - 1739000380866.json',
//               height: 200,
//             ),
//             SizedBox(height: 20),
//             GestureDetector(
//               onTap: _handleSignIn,
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: Colors.grey),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 5,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Image.asset(
//                       'assets/images/google (1).png',
//                       height: 24,
//                     ),
//                     SizedBox(width: 10),
//                     Text(
//                       'Google Sign In',
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             if (_isSigningIn) SizedBox(height: 20),
//             if (_isSigningIn) CircularProgressIndicator(),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:lovemug_creator/features/home/navigation_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleSignInPage extends StatefulWidget {
  @override
  _GoogleSignInPageState createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'], // Request Email and Profile
  );

  GoogleSignInAccount? _user; // Store User Info
  String? _idToken; // Store ID Token
  /// Handle Google Sign-In
  // Future<void> _handleSignIn() async {
  //   try {
  //     final GoogleSignInAccount? user = await _googleSignIn.signIn();
  //     if (user != null) {
  //       final GoogleSignInAuthentication auth = await user.authentication;
  //       setState(() {
  //         _user = user;
  //         _idToken = auth.idToken;
  //       });
  //       print("User Signed In: ${user.displayName}, ${user.email}, ${user.photoUrl} ,${user.id
  //       }{PPPPPPPPPPPPPPPP}${_idToken}");
  //
  //
  //       // Navigate to Home with User ID
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => NavigationBarPage(userId: user.id),
  //         ),
  //       );
  //     }
  //   } catch (error) {
  //     print('Sign in failed: $error');
  //   }
  // }


  Future<void> _handleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();
      if (user == null) {
        print("User canceled Google sign-in.");
        return;
      }

      final GoogleSignInAuthentication auth = await user.authentication;
      final String? idToken = auth.idToken;

      if (idToken == null) {
        print("Failed to get Google ID Token");

        return;
      }

      print("Google Sign-In successful: ${user.displayName}, ${user.email}${idToken}");

      // Send ID Token to Backend for Authentication
      try {
        final response = await http.post(
          Uri.parse('https://love-mug.onrender.com/api/auth/google'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"token": idToken}),
        );

        print("Response Status: ${response.statusCode}");
        print("Response Body: ${response.body}");

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          print("✅ Login successful: ${responseData['user']['name']}, ${responseData['user']['email']}");
        } else {
          print("❌ Login failed: ${response.body}");
        }
      } catch (e) {
        print("🚨 HTTP Request Error: $e");
      }

    } catch (error) {
      print('❌ Sign-in failed: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/Animation - 1739000380866.json',
              height: 200,
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap:(){
                _handleSignIn(context);
              }, // Call Sign-In Function
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/google (1).png',
                      height: 24,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Google Sign In',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            if (_user != null) ...[
              SizedBox(height: 20),
              CircleAvatar(
                backgroundImage: NetworkImage(_user!.photoUrl ?? ""),
                radius: 30,
              ),
              SizedBox(height: 10),
              Text("Name: ${_user!.displayName ?? "N/A"}"),
              Text("Email: ${_user!.email}"),
            ],
          ],
        ),
      ),
    );
  }
}

