import 'package:flutter/material.dart';
import 'package:lovemug_creator/core/constants/variables.dart';
import 'package:lovemug_creator/core/pallette/pallete.dart';
import 'package:lovemug_creator/features/call_earnings_management/screens/withdraw_earningspage.dart';
import '../../home/navigation_page.dart';
import 'call_history.dart';
import 'call_request_page.dart';
import 'earning_analytics.dart';


class CallAnalyticsPage extends StatelessWidget {
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
      child: DefaultTabController(
        length: 3, // Reduced to 3 tabs
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: primaryColor,
            title: Text(
              'Call Analytics',
              style: poppinsTextStyle(fontSize: 20, color: Colors.white),
            ),
            bottom: TabBar(
              indicator: BoxDecoration(
                color: primaryColor, // Color of the selected tab
              ),
              labelColor: Colors.white,
              labelStyle: poppinsTextStyle(fontSize: 10),
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                  text: 'Call History',
                  icon: Icon(Icons.history),
                ),
                Tab(
                  text: 'Earnings Analytics',
                  icon: Icon(Icons.analytics),
                ),
                Tab(
                  text: 'Withdraw Earnings',
                  icon: Icon(Icons.account_balance_wallet),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              CallHistoryScreen(),
              EarningsAnalyticsPage(),
              WithdrawEarningsPage(),
            ],
          ),
        ),
      ),
    );
  }
}
