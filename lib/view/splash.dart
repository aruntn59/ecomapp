import 'dart:async';
import 'package:ecomapp/view/Scarach..dart';
import 'package:ecomapp/view/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../Data/user_manager.dart';
import '../constants/colors.dart';
import 'login.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final UserManager _userManager = UserManager();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds:3),() async {
      String? id=await _userManager.getUserId();
      if(id==null){
        Navigator.pushAndRemoveUntil(
          context,
          // MaterialPageRoute(builder: (context) =>ScratchScreen()),
          MaterialPageRoute(builder: (context) => Signup()), // The new screen to navigate to
              (Route<dynamic> route) => false, // Condition to remove all previous routes
        );
      }else{
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()), // The new screen to navigate to
              (Route<dynamic> route) => false, // Condition to remove all previous routes
        );
      }
    }


    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:ColorConstant.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(width: 400, // Set the desired width
              height: 400,
              child: Lottie.asset("assets/animation/spash.json",fit: BoxFit.fill),
            ),
            Text  (
              'Shope',
              style: GoogleFonts.palanquinDark(
                  color: ColorConstant.red,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),

          ],
        ),
      ),
    );
  }
}
