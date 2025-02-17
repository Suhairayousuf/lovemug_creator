import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/variables.dart';
import '../../bank/screens/bank_detailes_screen.dart';
import '../../earnings/screens/earnings_summary.dart';
import '../../home/navigation_page.dart';
import '../../settings/screens/settings_widget.dart';
import 'edit_profile.dart';




class ProfileWidget extends StatefulWidget {
  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    // var width= MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationBarPage(initialIndex: 0, userId: '',),
          ),
              (route) => false,
        );
        return false; // Returning false ensures the current page will not pop.
      },
      child: Scaffold(

        body: Column(
          children: [
            SizedBox(height: 10,),
            _buildProfileHeader(),





            _buildMenuItem(Icons.credit_card, "Bank Detailes",1, ),
            SizedBox(height: 10,),

            _buildMenuItem(Icons.receipt, "Earnings and Summary",2),
            SizedBox(height: 10,),


            _buildMenuItem(Icons.settings, "Settings",3, showRedDot: true,),
            SizedBox(height: 10,),
            // _buildMenuItem(Icons.delete, "Delete Account",7, showRedDot: true,),
            // SizedBox(height: 10,),

            // _buildUserId(width:width),
            SizedBox(height: 15,),

            _buildVersionId(width:width),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        // height: 130,
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.deepPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20),top: Radius.circular(20) ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(""
                  "https://randomuser.me/api/portraits/women/44.jpg"), // Replace with actual profile image
            ),
            Row(
              children: [

                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // width: width*0.3,
                      child: Text("Samantha Rose",
                          style: poppinsTextStyle(color: Colors.white, fontSize: width*0.04, )),
                    ),
                    Text("Living the love 💖 | Looking for my match!", style: poppinsTextStyle(color: Colors.white70, fontSize: width*0.02,fontWeight: FontWeight.w600)),
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    //   decoration: BoxDecoration(
                    //     color: Colors.blue,
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   child: Text("Level 0", style: TextStyle(color: Colors.white, fontSize: 12)),
                    // ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0,left: 20),
                  child: Container(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        final updatedData = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(
                              // name: "user39731957",
                              // about: "Male, 25",
                              // profileImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTecaUSem5pKm6IOdlaUjz-2XTGd5wkZnzoNQ&s",
                            ),
                          ),
                        );
                        //                   if (updatedData != null) {
                        // setState(() {
                        // // userName = updatedData['name'];
                        // // userAbout = updatedData['about'];
                        // // userProfileImage = updatedData['profileImage'];
                        // });
                        // }

                      },
                      style: ElevatedButton.styleFrom(

                        backgroundColor: Colors.white24,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text("EDIT", style: poppinsTextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
            _buildProfileStatus(width: width),
            Text(
              "Love exploring new places, meeting new people, and finding someone special 💕",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title,int type, {String? trailingText, bool showRedDot = false}) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple,size: 30,),
      title: InkWell(onTap: (){
        if(type==1){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>BankDetailsScreen()));
        }else if(type==2){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>EarningsSummaryScreen()));

        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));

        }
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


  Widget _buildProfileStatus({required width}) {
    return FadeInLeft(
      duration: Duration(milliseconds: 800),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          color: Colors.white.withOpacity(0.2),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat("Followers", "12.5K"),
                _buildStat("Posts", "325"),
                _buildStat("Earnings", "\$1250"),
                _buildStat("Wallet", "\$250"),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // Widget for profile stats
  Widget _buildStat(String title, String value) {
    return InkWell(
      onTap: (){
        if(title=='Earnings'){
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>EarningsSummaryScreen()));
        }else if(title=='Posts'){
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>PostManagementScreen()));

        }
      },
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildVersionId({required width}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "v:0.01",
          style: poppinsTextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 10),
        ),
      ],
    );
  }
}
