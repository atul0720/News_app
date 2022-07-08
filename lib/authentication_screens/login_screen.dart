import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/authentication_screens/reset_password.dart';
import 'package:news_app/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'registration_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:google_sign_in/google_sign_in.dart'; // for google authentication
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:news_app/authentication_screens/Mobile_Authentication.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
// final keyword as we don't want any change
class _LoginScreenState extends State<LoginScreen> {

  // form key-> for getting email id and password when user click login
  final  _formKey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();


  @override
  Widget build(BuildContext context) {


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
        enabledBorder:OutlineInputBorder( // for decorating border
          borderSide: BorderSide( // for giving color
            width: 2.5,
            color: Colors.cyan.shade400,
                style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.circular(13),
        ),
        focusedBorder:OutlineInputBorder( // for decorating border
          borderSide: BorderSide( // for giving color
            width: 2.5,
              color: Colors.cyan.shade400,
              style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.circular(13),
        ),
      ),
    );

    // password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true, // for hiding password

      validator: (value){ // for checking the format of password entered
           RegExp regex  = new RegExp(r'^.{4,}$'); // for password restricted to 8 digits
          if(value!.isEmpty){
            return ("Password is required for Login");

          }
          if(!regex.hasMatch(value)){ // if value doesn't match
            return (" Enter Valid Password(Min. 4 Characters");
          }
      },
      onSaved: (value){ // function which store saved value
        passwordController.text = value!; // checking text entered by user is same or not
      },// for adding email address only in it
      textInputAction: TextInputAction.done, // not moving to other field after that
      decoration: InputDecoration( // for decorating field in this box
        prefixIcon: Icon(Icons.vpn_key,color: Colors.deepPurpleAccent,), // for mail icon
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password", // for hint text
        hintStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
          enabledBorder:OutlineInputBorder( // for decorating border
            borderSide: BorderSide( // for giving color
              width: 2.5,
                color: Colors.cyan.shade400,
            ),
            borderRadius: BorderRadius.circular(13),
          ),
          focusedBorder:OutlineInputBorder( // for decorating border
            borderSide: BorderSide(// for giving color
                width: 2.5, // for width of border
              color: Colors.cyan.shade400,
            ),
            borderRadius: BorderRadius.circular(13),
          ),
      ),
    );

    // login Button
    final LoginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color:Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width, // for setting its  min width of column size
        onPressed: () {
        signIn(emailController.text, passwordController.text); // for moving user to signIn function
        },
        child: Text("Login",textAlign: TextAlign.center,
        style:TextStyle(
          fontSize: 17.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold
        )),
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true, // for background color effect at starting of top bar
      body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF005b96),
            Color(0xFF03396c),

          ],
            stops: [ // for coloring background with percentage wise
              // first color take 10% space
              0.3,
              0.8,
            ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft
        )
      ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(36),
                child: Form( // for form type widget
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children :<Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5.5.h, 0, 0),
                        child: SizedBox(
                          height: 17.h,
                          child: Image.asset("images/r_icon1.png",fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 25,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 2),
                        child: Container(
                          child: Text("Hey,Welcome to APNA NEWS",
                              textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold,color:Colors.lightBlueAccent),
                          ),
                        ),
                      ),
                      SizedBox(height: 25,),
                      emailField,
                      SizedBox(height: 25,),
                      passwordField,
                      SizedBox(height: 35,),
                      LoginButton,
                      SizedBox(height: 15,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                          Text("Don't have an account? ",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.bold,color: Colors.white)),
                         GestureDetector(
                           onTap: (){ // for moving on registration screen when user tap on signup button
                             Navigator.push(context,MaterialPageRoute(builder: (context) => RegistrationScreen()));
                           },
                           child: Text("SignUp Here" , style:TextStyle(
                             color:Colors.lightBlueAccent,
                             fontWeight: FontWeight.bold,
                             fontSize: 15.sp,)),
                         ) // for when user click on this,

                       ],

                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize:MainAxisSize.max ,
                        children: [
                              SizedBox(height: 15,),
                           GestureDetector(
                             child: Text(
                               "Forgot Password?",
                               style: TextStyle(
                                 color: Colors.deepPurpleAccent.shade100,
                                 fontSize: 15.sp,
                                 fontWeight: FontWeight.bold
                               ),
                             ),
                             onTap: () async {
                               Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetPassword()));
                             }
                           ) ,

                          Container(
                            margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Divider( // for getting a Horizontal line
                                    indent: 10.0,
                                    endIndent: 10.0,
                                    thickness: 2,
                                    color: Colors.white,
                                  ),
                                ),
                                     Text("OR" ,style:TextStyle(
                                      color:Colors.cyan[500],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp,
                                    ),
                                    ),
                                   Expanded(
                                     child: Divider(
                                      indent: 10.0,
                                      endIndent: 10.0,
                                      thickness: 2,
                                       color: Colors.white,
                                  ),
                                   ),

                                  ],
                            ),
                          ),

                            //### For making Google Sign In Button

                            SizedBox(height: 1.0,) ,
                           SizedBox(
                             height: 8.h,
                             width: 190.h,
                                   child: Padding(
                                    padding:  EdgeInsets.fromLTRB(0, 1.h, 0, 0.5.h),
                                    child: SignInButton(
                                       Buttons.GoogleDark,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        elevation:30.0,


                               onPressed: () async{
                                     signInWithGoogle();
                               },
                             ),
                                   ),
                                 ),
                          SizedBox(height: 2.0.h,) ,
                          SizedBox(
                            height: 8.h,
                            width: 190.h,
                            child: Padding(
                              padding:  EdgeInsets.fromLTRB(0, 1.h, 0, 0.5.h),
                            child:  ElevatedButton.icon(
                                  onPressed: () async{
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Mobile()));
                                  },

                                  icon: Icon(Icons.phone,size: 30,),
                                  label: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text("Sign in with Mobile OTP",style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent[200],
                                shape: new RoundedRectangleBorder(
                                  borderRadius:  new BorderRadius.circular(20),
                                )
                              ),

                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //# Login function
  void signIn(String Email,String password) async
  {
    if(_formKey.currentState!.validate()){ // checking that the form conditions is satisfied
      await _auth.signInWithEmailAndPassword(email: Email, password: password)
          .then((uid) => {
            Fluttertoast.showToast(msg: "Login Successful",fontSize: 15.sp,backgroundColor: Colors.redAccent), //for showing toast message after login
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home())),// and move on to Home Screen
      }).catchError((e)
          {
            Fluttertoast.showToast(msg: e!.message); // show this error to user if not login
          });

    }
  }

// google sign in button function
// function to implement the google signin
  late String name;
  late String email;
  late String imageUrl;

  Future<String?> signInWithGoogle() async {

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
    await _auth.signInWithCredential(credential);
    final User? user = authResult.user;

    if (user != null) {
      // Checking if email and name is null
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);

      name = user.displayName!;
      email = user.email!;
      imageUrl = user.photoURL!;

      // Only taking the first part of the name, i.e., First Name
      if (name.contains(" ")) {
        name = name.substring(0, name.indexOf(" "));
      }

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User? currentUser = _auth.currentUser;
      assert(user.uid == currentUser?.uid);
      Fluttertoast.showToast(msg: "Sign In With Google Successful ",fontSize: 13.sp,backgroundColor: Colors.tealAccent);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
      return '$user';
    }

    return null;
  }


}

  






