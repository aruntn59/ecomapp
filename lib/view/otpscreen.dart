import 'package:ecomapp/view/Scarach..dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lottie/lottie.dart';
import '../Data/user_manager.dart';
import 'home_screen.dart';

class Otpscreen extends StatefulWidget {
  String ph;
   String verificationId;
    bool isCodeSent;
  Otpscreen({super.key, required this.ph, required this. verificationId, required this.isCodeSent });

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserManager _userManager = UserManager();
  void _copyTextToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      // Optionally show a snackbar or some UI to confirm the text was copied
      print('Text copied to clipboard!');
    });
  }
  Future<void> _signInWithOTP(String ph) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: ph,
      );
      await _auth.signInWithCredential(credential);
      _saveUserData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Phone number verified and user signed in")),

      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // Replace with your home screen
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to sign in. Error: ${e.toString()}")),
      );
    }
  }

  Future<void> _saveUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _userManager.saveUserData(user.uid, user.phoneNumber ?? '');
    }
  }

  Future<void> _checkUserAuthentication() async {
    String? userId = await _userManager.getUserId();
    if (userId != null) {
      // User is authenticated, proceed to the home screen or desired screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // Replace with your home screen
      );
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkUserAuthentication();
    if(!widget.isCodeSent==true){

      SmartDialog.show(builder: (_) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          alignment: Alignment.topCenter,
          child:Stack(

            children: [
              Container(
                width: double.infinity,
                height: 100,
                color: Colors.white,
                child: Center(
                  child: InkWell(
                    onLongPress: (){
                      _copyTextToClipboard("876567");
                      SmartDialog.dismiss();
                    },
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(text: 'Otp is :'),
                          TextSpan(text: '876567', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: "\nlong press to copy",style: TextStyle(fontSize:10,color: Colors.green ))

                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          )
        );
      });

    // SmartDialog.showNotify(msg: "Otp is: 876567", notifyType: NotifyType.success,alignment: Alignment.topCenter );

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFBFB),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 100, // Set the desired width
                height: 100,
                child: Lottie.asset("assets/animation/otplogo.json",fit: BoxFit.fill),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email, color: Colors.red,),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "+91 ${widget.ph}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xffFF7A06),
                              fontSize: 14),
                        ),
                      ],
                    )),
              ),

              OtpTextField(

                autoFocus: false,
                numberOfFields: 6,

                showFieldAsBox: true,
                onSubmit: (value){
                  if(widget.isCodeSent){
                    _signInWithOTP(value);
                  }else{
                    if(value=="876567"){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ScratchScreen()), // Replace with your home screen
                      );
                    }

                  }
                },
              ),
              SizedBox(height: 8,),
              Container(
                child: Center(
                  child: Text(
                    "Resend OTP after 60 sec",
                    style: TextStyle(
                        color: Color(0xff666666),
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ),
              ),
              SizedBox(height: 24,),
              Container(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context) => ScratchScreen(),));
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => HomeScreen()), // Replace with your home screen
                    // );



                  }, child: Text("Next",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white,fontSize: 18),),),
              )
            ],
          ),
        ),
      ),
    );





  }
}
