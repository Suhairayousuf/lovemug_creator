import 'package:flutter/material.dart';
import 'package:lovemug_creator/core/pallette/pallete.dart';

class WithdrawEarningsPage extends StatefulWidget {
  @override
  _WithdrawEarningsPageState createState() => _WithdrawEarningsPageState();
}

class _WithdrawEarningsPageState extends State<WithdrawEarningsPage> {
  final List<Map<String, String>> _withdrawalRequests = [];

  void _requestWithdrawal(BuildContext context) {
    final TextEditingController _amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Withdrawal Amount'),
          content: TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Enter amount"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String amount = _amountController.text;
                if (amount.isNotEmpty) {
                  setState(() {
                    _withdrawalRequests.add({
                      'amount': amount,
                      'status': 'Pending',
                      'date': DateTime.now().toString().split('.')[0],
                    });
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Withdrawal of \$${amount} requested successfully')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid amount')),
                  );
                }
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
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Request History'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _requestWithdrawal(context),
              child: Text('Request Withdrawal'),
            ),
            Expanded(
              child: _withdrawalRequests.isEmpty
                  ? Center(child: Text('No withdrawal requests yet.'))
                  : ListView.builder(
                itemCount: _withdrawalRequests.length,
                itemBuilder: (context, index) {
                  final request = _withdrawalRequests[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.attach_money, color: primaryColor),
                      title: Text('Amount: \$${request['amount']}'),
                      subtitle: Text('Status: ${request['status']}\nDate: ${request['date']}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
