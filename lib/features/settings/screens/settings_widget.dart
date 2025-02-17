import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/variables.dart';
import '../../home/navigation_page.dart';
import '../../ticket_system/screens/ticket_history.dart';
import 'blocked_user_list.dart';



class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool doNotDisturb = false;
  bool isPoliciesExpanded = false;
  Future<void> _softDeleteAccount(BuildContext context) async {
    // Show confirmation dialog
    bool? confirmed = await _showConfirmationDialog(context);

    if (confirmed == true) {
      // Here you can perform your soft delete logic, for example:
      // 1. Mark the account as deleted in your database (e.g., "isDeleted": true)
      // 2. Update UI to reflect the deactivation

      // Example of a message after account deletion
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Your account has been deactivated."),
      ));

      // Optionally navigate the user to a different screen or log them out
      // Navigator.pushReplacementNamed(context, '/login');
    }
  }

  // Show confirmation dialog for account deletion
  Future<bool?> _showConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Account Deletion'),
          content: Text('Are you sure you want to deactivate your account?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User canceled the delete
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirmed the delete
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
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
          title: Text("Settings"),
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () => Navigator.pop(context),
          // ),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            // Do Not Disturb Switch
            // _buildSwitchTile("Do not disturb", doNotDisturb, (value) {
            //   setState(() {
            //     doNotDisturb = value;
            //   });
            // }),

            // Upload Logs
            // _buildSimpleListTile("Upload logs", Icons.cloud_upload),

            // Expandable Our Policies Section
            _buildExpandablePolicies(),

            // Report a Problem
            Divider(),
            // _buildSimpleListTile("Tickets"
                // Icons.report
            // ),
            _buildMenuItem(Icons.receipt, "Tickets",3),
            SizedBox(height: 10,),

            _buildMenuItem(Icons.block, "Blocked & Hidden List",5),

            // _buildSimpleListTile("Blocked Users"
            //     // Icons.report
            // ),

            // Delete Account
        _buildMenuItem(Icons.delete, "Delete Account",5),

      // _buildSimpleListTile("Delete Account"
      //           // Icons.delete, textColor: Colors.red
      //       ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title,int type, {String? trailingText, bool showRedDot = false}) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple,size: 30,),
      title: InkWell(
          onTap: () {
            if(title=='Delete Account'){
              _softDeleteAccount(context);


            }else if(title=='Blocked & Hidden List'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BlockedUsersScreen()));


            }else if(title=='Tickets'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TicketHistoryScreen()));

            }
            // Implement functionality
          },
          child: Text(title, style: GoogleFonts.poppins(fontSize: 19))),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null) Text(trailingText, style: GoogleFonts.poppins(color: Colors.green)),
          // if (showRedDot)
          //   Padding(
          //     padding: const EdgeInsets.only(left: 8),
          //     child: Icon(Icons.circle, color: Colors.red, size: 8),
          //   ),
          Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
      onTap: () {},
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  // Widget _buildSimpleListTile(String title, IconData icon, {Color textColor = Colors.black}) {
  Widget _buildSimpleListTile(String title, {Color textColor = Colors.black}) {
    return ListTile(
      // leading: Icon(icon, color: Colors.grey),
      title: Text(title, style: poppinsTextStyle(fontSize: 16, color: textColor)),
      onTap: () {
        if(title=='Delete Account'){
          _softDeleteAccount(context);


        }else if(title=='Blocked Users'){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>BlockedUsersScreen()));


        }else if(title=='Ticket System'){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>TicketHistoryScreen()));

        }
        // Implement functionality
      },
    );
  }

  Widget _buildExpandablePolicies() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ExpansionTile(
        title: Text("Our Policies", style: poppinsTextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        initiallyExpanded: isPoliciesExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            isPoliciesExpanded = expanded;
          });
        },
        children: [
          _buildPolicyItem("Privacy Policy"),
          _buildPolicyItem("Terms of Use"),
          _buildPolicyItem("Delivery, Refund And Cancellation Policy"),
          _buildPolicyItem("Community Guidelines"),
          _buildPolicyItem("Compliance Statement"),
          _buildPolicyItem("Content Moderation Policy"),
        ],
      ),
    );
  }

  Widget _buildPolicyItem(String title) {
    return ListTile(
      leading: Icon(Icons.circle, size: 8, color: Colors.black), // Small bullet point

      title: Text("$title", style: poppinsTextStyle(fontSize: 16)),
      onTap: () {
        // Navigate to the policy page
      },
    );
  }
}
