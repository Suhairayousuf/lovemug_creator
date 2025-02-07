// import 'package:flutter/material.dart';
//
// class AddTicketScreen extends StatefulWidget {
//   @override
//   _AddTicketScreenState createState() => _AddTicketScreenState();
// }
//
// class _AddTicketScreenState extends State<AddTicketScreen> {
//   final _formKey = GlobalKey<FormState>(); // Form key for validation
//
//   // Controllers for TextFields
//   final TextEditingController _ticketIdController = TextEditingController();
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _statusController = TextEditingController();
//
//   // Function to handle ticket submission
//   void _submitTicket() {
//     if (_formKey.currentState!.validate()) {
//       // If form is valid, process the data
//       final String ticketId = _ticketIdController.text;
//       final String title = _titleController.text;
//       final String status = _statusController.text;
//
//       // You can now save or submit the data to your backend or database
//       print("Ticket ID: $ticketId");
//       print("Title: $title");
//       print("Status: $status");
//
//       // Clear the form after submission
//       _ticketIdController.clear();
//       _titleController.clear();
//       _statusController.clear();
//
//       // Show a success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Ticket Raised Successfully!')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Raise a New Ticket"), backgroundColor: Colors.purple),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Ticket ID TextField
//               TextFormField(
//                 controller: _ticketIdController,
//                 decoration: InputDecoration(
//                   labelText: 'Ticket ID',
//                   hintText: 'Enter ticket ID',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a ticket ID';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//
//               // Title TextField
//               TextFormField(
//                 controller: _titleController,
//                 decoration: InputDecoration(
//                   labelText: 'Title',
//                   hintText: 'Enter ticket title',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a title';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//
//               // Status TextField
//               TextFormField(
//                 controller: _statusController,
//                 decoration: InputDecoration(
//                   labelText: 'Status',
//                   hintText: 'Enter ticket status (e.g., Open, Closed)',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a status';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//
//               // Submit Button
//               ElevatedButton(
//                 onPressed: _submitTicket,
//                 child: Text('Add Ticket'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.purple,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
