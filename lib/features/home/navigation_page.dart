import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';
import '../../model/user_model.dart';
import '../chats/screens/chat_widget.dart';
import '../post_creation/screens/post_list_screen.dart';
import '../call_earnings_management/screens/call_tile_page.dart';
import '../audience_engagement/screens/audience_screen.dart';
import '../profile/screens/profile_screen.dart';

class NavigationBarPage extends StatefulWidget {

  final int initialIndex;
  final String userId; // Accept userId for API call

  const NavigationBarPage({Key? key, this.initialIndex = 0, required this.userId}) : super(key: key);

  @override
  _NavigationBarPageState createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int _selectedIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    bool success = await ApiService.fetchUserData(widget.userId);
    if (success) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  static final List<Widget> _widgetOptions = <Widget>[
    PostListScreen(),
    CallAnalyticsPage(),
    AudienceEngagementPage(),
    ChatWidget(),
    ProfileWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.sizeOf(context).width;
    return Scaffold(

      backgroundColor: Colors.white,
      body:
      // _isLoading
      //     ? Center(child: CircularProgressIndicator())
      //     :
      _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: ''),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey.shade800,
        onTap: _onItemTapped,
      ),
    );
  }

}
class ApiService {
  static const String baseUrl = "https://yourbackend.com/api"; // Replace with your API URL

  static Future<bool> fetchUserData(String userId) async {
    final url = Uri.parse("$baseUrl/users/$userId"); // Adjust according to your backend API

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        User user = User.fromJson(data);

        // Store user globally
        UserData.setUser(user);
        return true;
      } else {
        print("Error fetching user data: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }
}