
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword>  { // using widgetsBindingObserver for email link
final formKey = GlobalKey<FormState>();
final TextEditingController emailController = new TextEditingController();


  @override
  Widget build(BuildContext context) {


    final FirebaseAuth auth = FirebaseAuth.instance;
    // email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value!.isEmpty){ // for checking value added or not
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.[a-z]").hasMatch(value)){
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value){ // function which store saved value
        emailController.text = value!; // checking text entered by user is same or not
      },// for adding email address only in it
      textInputAction: TextInputAction.next, // for moving on to next field after next button in keyboard
      decoration: InputDecoration( // for decorating field in this box
        prefixIcon: Icon(Icons.mail,color: Colors.deepPurpleAccent,), // for mail icon
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email", // for hint text
        hintStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
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
    );

    return Scaffold(
      extendBodyBehindAppBar: true, // for background color effect at starting of top bar
        appBar: AppBar(
        backgroundColor: Colors.transparent, // for color upto appbar top position
        elevation: 0,
        title: Text(
        "Apna News ",
        style: TextStyle(
        fontFamily: 'RobotoCondensed Bold',
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontSize: 15.sp),
    ),
        ),
    body: Container(
      decoration: BoxDecoration( // for Linear Gradient color of App
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
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Receive an Email to reset Your Password",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w600,color: Colors.white),
              ),
              SizedBox(height: 3.h,),
              emailField,
              SizedBox(height: 20,),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13)
                  )
                ),
                icon: Icon(Icons.email_outlined),
                label: Text("Reset Password",style: TextStyle(fontSize: 15.sp),),
                onPressed: () async {
                await  FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                }// for moving on to Reset Password Function
              ),

             ]
          )
        ),
        ),
    ),

    );

  }
}
