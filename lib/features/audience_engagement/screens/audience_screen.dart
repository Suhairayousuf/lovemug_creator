import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:animations/animations.dart';
import 'package:lovemug_creator/core/constants/variables.dart';
import 'package:lovemug_creator/core/pallette/pallete.dart';

import '../../home/navigation_page.dart';
import 'follower_chat_screen_.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AudienceEngagementPage extends StatefulWidget {
  @override
  _AudienceEngagementPageState createState() => _AudienceEngagementPageState();
}

class _AudienceEngagementPageState extends State<AudienceEngagementPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationBarPage(initialIndex: 0, userId: '',),
          ),
              (route) => false,
        );
        return false; // Prevents the current page from popping
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          title: Text('Audience Engagement',style: poppinsTextStyle(fontSize: 20,color: Colors.white),),
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.grey,

            controller: _tabController,
            tabs: [
              Tab(text: 'Followers'),
              Tab(text: 'Dashboard'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            FollowerListPage(),
            EngagementDashboard(),
          ],
        ),
      ),
    );
  }
}

// class FollowerListPage extends StatelessWidget {
//   final List<String> followers = ['Alice', 'Bob', 'Charlie', 'David'];
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(10.0),
//       child: ListView.builder(
//         itemCount: followers.length,
//         itemBuilder: (context, index) {
//           return Card(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//             elevation: 5,
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//             child: ListTile(
//               contentPadding: EdgeInsets.all(10),
//               leading: CircleAvatar(
//                 radius: 30,
//                 backgroundColor: primaryColor,
//                 child: Text(
//                   followers[index][0],
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//               ),
//               title: Text(
//                 followers[index],
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text('Active now', style: TextStyle(color: Colors.green)),
//               trailing: Stack(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.chat_bubble, color: primaryColor),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ChatPage(followerName: followers[index]),
//                         ),
//                       );
//
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Chat with ${followers[index]} started!')),
//                       );
//                     },
//                   ),
//                   Positioned(
//                     right: 6,
//                     top: 6,
//                     child: Container(
//                       padding: EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Text(
//                         '!',
//                         style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class FollowerListPage extends StatefulWidget {
  @override
  _FollowerListPageState createState() => _FollowerListPageState();
}

class _FollowerListPageState extends State<FollowerListPage> {
  late Future<List<String>> _followersFuture;

  @override
  void initState() {
    super.initState();
    _followersFuture = fetchFollowers();
  }

  Future<List<String>> fetchFollowers() async {
    try {
      final response = await http.get(Uri.parse('https://yourapi.com/api//followers/:user_id'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => item['name'].toString()).toList();
      } else {
        throw Exception("Failed to load followers");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: FutureBuilder<List<String>>(
        future: _followersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No followers found."));
          }

          final followers = snapshot.data!;

          return ListView.builder(
            itemCount: followers.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue, // Change as needed
                    child: Text(
                      followers[index][0].toUpperCase(),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  title: Text(
                    followers[index],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Active now', style: TextStyle(color: Colors.green)),
                  trailing: IconButton(
                    icon: Icon(Icons.chat_bubble, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(followerName: followers[index]),
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Chat with ${followers[index]} started!')),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


class EngagementDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Engagement Growth', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 2),
                      FlSpot(1, 4),
                      FlSpot(2, 3),
                      FlSpot(3, 6),
                      FlSpot(4, 8),
                    ],
                    isCurved: true,
                    color: primaryColor,
                    barWidth: 4,
                    isStrokeCapRound: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
