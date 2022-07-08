import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/authentication_screens/login_screen.dart';
import 'package:news_app/home.dart';
import 'package:sizer/sizer.dart';

//## For Mobile Authentication
enum Login{ // it is a Variable where we define value of variables and we can change it
  SHOW_MOBILE_ENTER_WIDGET,
  SHOW_OTP_FORM_WIDGET,
}
class Mobile extends StatefulWidget {
  const Mobile({Key? key}) : super(key: key);

  @override
  State<Mobile> createState() => _Mobile();
}

class _Mobile extends State<Mobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Mobile OTP Verification Screen",style: TextStyle(fontFamily: 'Merriweather Bold', fontWeight: FontWeight.w700,color:Colors.white ,fontSize: 15.sp)),

        leading: IconButton( // for back button in app
          icon: Icon(Icons.arrow_back, color: Colors.white,size: 30,),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())),

        ),

        titleSpacing: 25,
      ) ,
      body: Container(
        decoration: BoxDecoration( // for changing background color of app
            gradient: LinearGradient(
                colors: [
                  Color(0xFF005b96),
                  Color(0xFF03396c),

                ],
                stops: [ // for coloring background with percentage wise
                  0.3, // first color take 10% space
                  0.8,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft
            )
        ),
        child: currentState == Login.SHOW_MOBILE_ENTER_WIDGET ? showMobilePhoneWidget(context) : showOtpFormWidget(context),)
    );
    
    
  }


  // ## For Mobile OTP Authentication
  TextEditingController phoneController = TextEditingController(); // creating phoneController
  TextEditingController otpController = TextEditingController(); // for storing otp entered by user
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Login currentState = Login.SHOW_MOBILE_ENTER_WIDGET;
  String verificationID = ""; // verification id
  //# creating mobile phone widget
  void signInWithPhoneAuthCred(AuthCredential phoneAuthCredential) async { // method of sign in with otp
    try{
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);

      if(authCred.user != null){ // when successful sign in then this code will run
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Some Error Occured. Try Again Later')));
    }
  }


  showMobilePhoneWidget(context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(),
        Text("Verify Your Phone Number", style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold,color: Colors.redAccent),),
        SizedBox(height: 7,),
        SizedBox(height: 10,),
        Center(
          child: SizedBox(
            width: 45.h,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(

                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Enter Your Phone Number",
                    hintStyle: TextStyle(color: Colors.white,fontSize: 15.sp,fontWeight: FontWeight.w500),
                    prefixIcon: Icon( Icons.phone,color: Colors.deepPurpleAccent,), // for align text inside TextField
                   filled: true, // for filling color in textfield
                  fillColor: Colors.purpleAccent[300],
                  // for filing color in textfield
                  enabledBorder: OutlineInputBorder( // for changing outlined border
                    borderSide: BorderSide(
                      width: 2.5,
                      color: Colors.cyan.shade400,
                      style: BorderStyle.solid
                    ),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.5,
                      color: Colors.cyan.shade400,
                      style: BorderStyle.solid
                    ),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),
        ElevatedButton(onPressed: () async {
          await _auth.verifyPhoneNumber( // for verify phone no we provide phone no here
            phoneNumber: "+91${phoneController.text}",
            verificationCompleted: (phoneAuthCredential) async {  // when verification complete this code run

            },
            verificationFailed: (FirebaseAuthException e){  // code when verification failed
              if(e.code == 'invalid-phone-number') {
                print('The provided phone number is not valid');
              }
            },

            codeSent: (String verificationID,int? resendingToken)  async{ // code when successfully code sent from firebase
              setState(() {
                String smsCode = 'xxxx';
                currentState = Login.SHOW_OTP_FORM_WIDGET; // when successful code sent move to otp form widget
                this.verificationID = verificationID; // matching id with otp which is sen from firebase here
              });
            },
            timeout: const Duration(seconds: 120), // timeout code after 2 minutes
            codeAutoRetrievalTimeout: (String verificationID) async{

            },
          );  // code when auto retrieval timeout
        },
            style: ElevatedButton.styleFrom( // for changing shape of elevated button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13)
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Text("Send OTP",style: TextStyle(fontSize: 16.sp),),
            )
        ),
        SizedBox(height: 16,),
        Spacer()
      ],
    );
  }

  // creating Otp form widget here
  showOtpFormWidget(context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(),
        Text("Enter Your OTP", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        SizedBox(height: 7,),
        SizedBox(height: 20,),
        Center(
          child: TextField(
            controller: otpController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: "Enter Your OTP"

            ),
          ),
        ),
        SizedBox(height: 20,),
        ElevatedButton(onPressed: () {
          AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otpController.text);
          signInWithPhoneAuthCred(phoneAuthCredential);
        },
            child: Text("Verify",style: TextStyle(fontWeight: FontWeight.bold),)
        ),
        SizedBox(height: 16,),
        Spacer()
      ],
    );
  }


}

