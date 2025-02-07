import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

import '../../earnings/screens/earnings_summary.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.deepPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Scrollable Content
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 80),

                // Animated Profile Picture
                Center(
                  child: Pulse(
                    infinite: true,
                    duration: Duration(seconds: 3),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pinkAccent.withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            "https://randomuser.me/api/portraits/women/44.jpg"),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15),

                // Username
                FadeInDown(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    "Samantha Rose",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                // Status Message
                FadeInDown(
                  duration: Duration(milliseconds: 700),
                  child: Text(
                    "Living the love 💖 | Looking for my match!",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // Profile Stats - Followers, Posts, Wallet, Earnings
                FadeInLeft(
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
                ),

                SizedBox(height: 20),

                // Bio Section
                FadeInUp(
                  duration: Duration(milliseconds: 900),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Love exploring new places, meeting new people, and finding someone special 💕",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 50),
              ],
            ),
          ),

          // Floating Edit Profile Button
          Positioned(
            bottom: 30,
            right: 30,
            child: BounceInUp(
              duration: Duration(milliseconds: 1000),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen()));
                  // Navigate to Edit Profile
                },
                child: Icon(Icons.edit, color: Colors.pinkAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for profile stats
  Widget _buildStat(String title, String value) {
    return InkWell(
      onTap: (){
        if(title=='Earnings'){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>EarningsSummaryScreen()));
        }
      },
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
