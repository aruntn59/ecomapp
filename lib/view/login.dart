import 'package:ecomapp/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lottie/lottie.dart';


import 'otpscreen.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController textEditingController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';
  bool _isCodeSent = false;

  Future<void> _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91${textEditingController.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        SmartDialog.dismiss();
        print("Phone number automatically verified");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Phone number automatically verified")),
        );
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                Otpscreen(ph:textEditingController.text, verificationId: _verificationId,isCodeSent: _isCodeSent,)
            ));

      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
        SmartDialog.dismiss();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                Otpscreen(ph:textEditingController.text, verificationId: _verificationId,isCodeSent: _isCodeSent,)
            ));
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("Verification failed. ${e.message}")),
        // );
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          _isCodeSent = true;
        });
        SmartDialog.dismiss();
       if(_isCodeSent){
         Navigator.pushReplacement(context,
           MaterialPageRoute(builder:
               (context) =>
               Otpscreen(ph:textEditingController.text, verificationId: _verificationId,isCodeSent: _isCodeSent,)
           ));}

      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.white,
        title: Text("SignUp",style:TextStyle(color: ColorConstant.red,fontWeight: FontWeight.w900),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Container(height: 600,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.9),
                  spreadRadius: 1,
                  blurRadius: 5,
                  // offset: Offset(2, 2),
                ),
              ],
            ),

            // width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 100, // Set the desired width
                    height: 100,
                    child: Lottie.asset("assets/animation/login.json",fit: BoxFit.fill),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child:TextFormField(
                      cursorColor:  ColorConstant.red,
                      maxLength: 10,
                      controller: textEditingController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: ColorConstant.red),
                      decoration: InputDecoration(
                        // hintText: "Enter Phone No",
                        labelText: "Phone Number",
                        hintStyle: TextStyle(color: ColorConstant.red), // Set hint text color to yellow
                        labelStyle: TextStyle(color: ColorConstant.red), // Set label text color to yellow
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:  ColorConstant.red), // Change underline color when focused
                        ),
                      ),
                      validator: (value) {
                        if (value!.length != 10 || value.isEmpty) {
                          return 'Please enter some valid phone number';
                        }
                        return null;
                      },

                    ),

                  ),

                  Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              SmartDialog.showLoading(msg: "please wait...");
                              _verifyPhoneNumber();

                            }
                          }, child: Text("Sign Up",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white,fontSize: 18),),),
                      )
                  )


                ],),
            ),),
        ),
      ),
    );
  }
}
