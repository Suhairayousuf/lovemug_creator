import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovemug_creator/core/constants/variables.dart';

import '../../../core/pallette/pallete.dart';

class EarningsSummaryScreen extends StatefulWidget {
  @override
  _EarningsSummaryScreenState createState() => _EarningsSummaryScreenState();
}

class _EarningsSummaryScreenState extends State<EarningsSummaryScreen> {
  double currentBalance = 2500.75; // Sample balance amount
  double callCommission = 150.50; // Sample call commission

  String selectedMonth = "February";
  String selectedYear = "2025";

  List<Map<String, dynamic>> payoutHistory = [
    {"date": "01 Feb 2025", "amount": 500, "status": "Completed"},
    {"date": "15 Jan 2025", "amount": 300, "status": "Completed"},
    {"date": "10 Dec 2024", "amount": 200, "status": "Pending"},
  ];
  List<String> _generateYears() {
    int currentYear = DateTime.now().year;
    return List.generate(15, (index) => (currentYear - index).toString());
  }

  void _requestPayout() {
    if (currentBalance < 500) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Minimum payout amount is ₹500")),
      );
    } else {
      setState(() {
        currentBalance -= 500; // Deduct payout
        payoutHistory.insert(0, {"date": "07 Feb 2025", "amount": 500, "status": "Processing"});
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payout request of ₹500 submitted")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Earnings Summary", style: GoogleFonts.poppins(color: Colors.white)),
          centerTitle: true,
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back,color: Colors.white,)
          ),
          backgroundColor: primaryColor,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              height: 50,

              child: TabBar(
                labelColor: Colors.white, // White text for selected tab
                unselectedLabelColor: Colors.grey, // Primary color for unselected tabs
                // indicator: BoxDecoration(
                //   color: Colors.white, // Primary color background for selected tab
                //   borderRadius: BorderRadius.circular(10), // Smooth selection effect
                // ),
                labelStyle: poppinsTextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(text: "Current Earnings"),
                  Tab(text: "Payout History"),
                ],
              ),
            ),
          ),


        ),
        body: TabBarView(
          children: [
            _buildCurrentEarningsTab(),
            _buildPayoutHistoryTab(),
          ],
        ),
      ),
    );
  }

  // Current Earnings Tab
  Widget _buildCurrentEarningsTab() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _buildEarningsCard("Current Balance", "₹${currentBalance.toStringAsFixed(2)}", Icons.account_balance_wallet),
          SizedBox(height: 20),
          _buildEarningsCard("Call Commissions (Audio Only)", "₹${callCommission.toStringAsFixed(2)}", Icons.mic),
          SizedBox(height: 40),

          // Request Payout Button
          ElevatedButton(
            onPressed: _requestPayout,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text("Request Payout", style: GoogleFonts.poppins(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Payout History Tab
  Widget _buildPayoutHistoryTab() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Dropdown Filters
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDropdown(["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"], selectedMonth, (String? value) {
                if (value != null) {
                  setState(() => selectedMonth = value);
                }
              }),
              _buildDropdown( _generateYears(),
                  selectedYear, (String? value) {
                if (value != null) {
                  setState(() => selectedYear = value);
                }
              }),
            ],
          ),
          SizedBox(height: 20),

          // Payout History List
          Expanded(
            child: payoutHistory.isEmpty
                ? Center(child: Text("No payout history", style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey)))
                : ListView.builder(
              itemCount: payoutHistory.length,
              itemBuilder: (context, index) {
                var item = payoutHistory[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    title: Text("₹${item['amount']}", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(item['date']),
                    trailing: Text(
                      item['status'],
                      style: TextStyle(
                        color: item['status'] == "Completed" ? Colors.green : Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Custom Earnings Card Widget
  Widget _buildEarningsCard(String title, String value, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, color:primaryColor, size: 30),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey)),
                SizedBox(height: 5),
                Text(value, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Custom Dropdown Widget
  Widget _buildDropdown(List<String> items, String selectedValue, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: selectedValue,
      icon: Icon(Icons.arrow_drop_down),
      onChanged: onChanged,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: GoogleFonts.poppins(fontSize: 16)),
        );
      }).toList(),
    );
  }
}
