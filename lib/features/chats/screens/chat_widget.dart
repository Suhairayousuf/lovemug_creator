import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/variables.dart';
import '../../../core/pallette/pallete.dart';
import '../../../core/utils/utils.dart';
import '../../home/navigation_page.dart';
import 'creators.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  @override
  Widget build(BuildContext context) {
   // var width = MediaQuery.of(context).size.width;
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          title: Text('CHATS',style: TextStyle(color: Colors.white,fontSize: 20),),
          actions: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Icon(Icons.notification_important_outlined,size: 35,color: Colors.white,),
                ),
                Positioned(
                  right: 8,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '!',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),

          ],

        ),
        body: Center(
          child: Container(
            child: Text('No data Found',style:poppinsTextStyle(fontSize: 15) ,),
          ),
        ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding:  EdgeInsets.all(width*0.05),
            child: SizedBox(
              height: width*0.12,
              width: width*0.35,
              child: FloatingActionButton.extended(

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                backgroundColor: primaryColor,
                onPressed: () async {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>FollowerListWidget()));


                  // Handle the button press

                },
                label: Row(
                  children: [
                    Icon(Icons.add,color: Colors.white,),
                    SizedBox(width: width*0.02),
                    Text(
                      "Start Chat",
                      style: GoogleFonts.inter(fontSize: width*0.04,color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
