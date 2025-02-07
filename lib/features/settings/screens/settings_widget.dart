import 'package:flutter/material.dart';

import '../../../core/constants/variables.dart';



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
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
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
          _buildSimpleListTile("Report a problem"
              // Icons.report
          ),

          // Delete Account
          _buildSimpleListTile("Delete Account"
              // Icons.delete, textColor: Colors.red
          ),
        ],
      ),
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
