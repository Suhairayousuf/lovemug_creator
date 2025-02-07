import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovemug_creator/core/constants/variables.dart';
import 'package:lovemug_creator/core/pallette/pallete.dart';

class BankDetailsScreen extends StatefulWidget {
  @override
  _BankDetailsScreenState createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountHolderController = TextEditingController();

  bool isEditing = false;
  bool isAddingNewAccount = false;

  // Sample stored bank details (Replace with database fetching logic)
  List<Map<String, String>> bankAccounts = [
    {
      "accountNumber": "123456789012",
      "ifsc": "HDFC0001234",
      "bankName": "HDFC Bank",
      "accountHolder": "Samantha Rose"
    }
  ];

  void _toggleEditMode(int index) {
    setState(() {
      isEditing = !isEditing;
      if (isEditing) {
        _accountNumberController.text = bankAccounts[index]["accountNumber"] ?? "";
        _ifscController.text = bankAccounts[index]["ifsc"] ?? "";
        _bankNameController.text = bankAccounts[index]["bankName"] ?? "";
        _accountHolderController.text = bankAccounts[index]["accountHolder"] ?? "";
      }
    });
  }

  void _toggleAddNewAccount() {
    setState(() {
      isAddingNewAccount = !isAddingNewAccount;
      if (isAddingNewAccount) {
        _accountNumberController.clear();
        _ifscController.clear();
        _bankNameController.clear();
        _accountHolderController.clear();
      }
    });
  }

  void _saveBankDetails(int? index) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        if (index != null) {
          // Update existing account
          bankAccounts[index] = {
            "accountNumber": _accountNumberController.text,
            "ifsc": _ifscController.text,
            "bankName": _bankNameController.text,
            "accountHolder": _accountHolderController.text
          };
        } else {
          // Add new account
          bankAccounts.add({
            "accountNumber": _accountNumberController.text,
            "ifsc": _ifscController.text,
            "bankName": _bankNameController.text,
            "accountHolder": _accountHolderController.text
          });
        }

        isEditing = false;
        isAddingNewAccount = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Bank details updated successfully!")),
      );
    }
  }

  void _deleteBankAccount(int index) {
    setState(() {
      bankAccounts.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Bank account deleted successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Details", style: GoogleFonts.poppins(color: Colors.white)),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.white,)
        ),
        actions: [
          if (bankAccounts.isNotEmpty)
            IconButton(
              icon: Icon(Icons.add,color: Colors.white,),
              onPressed: _toggleAddNewAccount,
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: bankAccounts.isEmpty && !isAddingNewAccount
            ? Center(
          child: ElevatedButton(
            onPressed: _toggleAddNewAccount,
            child: Text("Add Bank Account",style: poppinsTextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
            ),
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isAddingNewAccount)
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: bankAccounts.length,
                  itemBuilder: (context, index) {
                    var account = bankAccounts[index];
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text(
                          "**** **** **** ${account['accountNumber']!.substring(account['accountNumber']!.length - 4)}",
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("${account['bankName']} (${account['ifsc']})"),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == "Edit") _toggleEditMode(index);
                            if (value == "Delete") _deleteBankAccount(index);
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(value: "Edit", child: Text("Edit")),
                            PopupMenuItem(value: "Delete", child: Text("Delete", style: TextStyle(color: Colors.red))),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

            if (isEditing || isAddingNewAccount)
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildTextField("Account Number", _accountNumberController, TextInputType.number, true),
                        SizedBox(height: 10),
                        _buildTextField("IFSC Code", _ifscController),
                        SizedBox(height: 10),
                        _buildTextField("Bank Name", _bankNameController),
                        SizedBox(height: 10),
                        _buildTextField("Account Holder Name", _accountHolderController),
                        SizedBox(height: 20),

                        // Save & Cancel Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () => _saveBankDetails(isEditing ? bankAccounts.indexWhere((element) => element['accountNumber'] == _accountNumberController.text) : null),
                              child: Text("Save",style: poppinsTextStyle(color: Colors.white),),
                              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isEditing = false;
                                  isAddingNewAccount = false;
                                });
                              },
                              child: Text("Cancel"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      [TextInputType keyboardType = TextInputType.text, bool isNumber = false]) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isNumber,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Please enter $label";
        if (label == "IFSC Code" && value.length != 11) return "Enter a valid 11-digit IFSC Code";
        if (label == "Account Number" && (value.length < 10 || value.length > 18)) return "Enter a valid account number";
        return null;
      },
    );
  }
}
