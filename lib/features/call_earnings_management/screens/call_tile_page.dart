import 'package:flutter/material.dart';
import 'package:lovemug_creator/core/pallette/pallete.dart';

import 'call_request_page.dart';



class CallTilePage extends StatefulWidget {
  @override
  State<CallTilePage> createState() => _CallTilePageState();
}

class _CallTilePageState extends State<CallTilePage> {
  final List<Map<String, dynamic>> sections = [
    {
      'id': 0,
      'title': 'Call Request',
      'icon': Icons.call,
      'color': Colors.blue,
      'route': '/IncomingCallScreen',
    },
    {
      'id': 1,
      'title': 'Call History',
      'icon': Icons.history,
      'color': Colors.green,
      'route': '/callHistory',
    },
    {
      'id': 2,
      'title': 'Earnings Analytics',
      'icon': Icons.analytics,
      'color': Colors.orange,
      'route': '/earningsAnalytics',
    },
    {
      'id': 3,

      'title': 'Withdraw Earnings',
      'icon': Icons.account_balance_wallet,
      'color': Colors.red,
      'route': '/withdrawEarnings',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Analytics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: sections.length,
          itemBuilder: (context, index) {
            final section = sections[index];
            return GestureDetector(
              onTap: () {
                if(section['id']==0){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>IncomingCallScreen()));

                }
                // Navigator.pushNamed(context, section['route']);
              },
              child: Card(
                color: primaryColor.withOpacity(0.7),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      section['icon'],
                      size: 48.0,
                      color: Colors.white,
                      // color: section['color'],
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      section['title'],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
