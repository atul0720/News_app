import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/authentication_screens/model/user_model.dart';
import 'package:news_app/home.dart';
import 'package:sizer/sizer.dart';


import 'login_screen.dart'; // for importing login_screen widget

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance; // object of firebase function
  //formkey
  final _formKey = GlobalKey<FormState>(); //creating  form key here

  //editing controllers

  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final conformPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
// first name
    final firstnNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value){ // for checking the format of Firstname entered
        RegExp regex  = new RegExp(r'^.{3,}$'); // for firstname  restricted to min 3 digits
        if(value!.isEmpty){
          return ("First Name cannot be Empty");
        }
        if(!regex.hasMatch(value)){ // if value doesn't match
          return (" Enter Valid First name(Min. 3 Characters");
        }
        return null;
      },
      onSaved: (value){ // function which store saved value
        firstNameEditingController.text = value!; // checking text entered by user is same or not
      },// for adding email address only in it
      textInputAction: TextInputAction.next, // for moving on to next field after next button in keyboard
      decoration: InputDecoration( // for decorating field in this box
        prefixIcon: Icon(Icons.account_circle,color: Colors.deepPurpleAccent,), // for mail icon
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "First Name", // for hint text
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

    // second name
    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value){ // for checking the format of second name entered
        if(value!.isEmpty){ // if empty return value not found
          return ("Second Name cannot be Empty");
        }
        return null;
      },
      onSaved: (value){ // function which store saved value
        secondNameEditingController.text = value!; // checking text entered by user is same or not
      },// for adding email address only in it
      textInputAction: TextInputAction.next, // for moving on to next field after next button in keyboard
      decoration: InputDecoration( // for decorating field in this box
        prefixIcon: Icon(Icons.account_circle,color: Colors.deepPurpleAccent,), // for user icon
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Second Name", // for hint text
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

    // email
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
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
        emailEditingController.text = value!; // checking text entered by user is same or not
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

    // password
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,  // for hiding text
      validator: (value){ // for checking the format of password entered
        RegExp regex  = new RegExp(r'^.{4,}$'); // for password restricted to 4 digits
        if(value!.isEmpty){
          return ("Password is required for Login");
        }
        if(!regex.hasMatch(value)){ // if value doesn't match
          return (" Enter Valid Password(Min. 4 Characters");
        }
      },
      onSaved: (value){ // function which store saved value
        passwordEditingController.text = value!; // checking text entered by user is same or not
      },// for adding email address only in it
      textInputAction: TextInputAction.next, // for moving on to next field after next button in keyboard
      decoration: InputDecoration( // for decorating field in this box
        prefixIcon: Icon(Icons.vpn_key,color: Colors.deepPurpleAccent,), // for mail icon
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password", // for hint text
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

    // conform password
    final conformPasswordField = TextFormField(
      autofocus: false,
      controller: conformPasswordEditingController,
      obscureText: true,
      // for checking validator or conform password or matching with previous password or have value greater than 4
      validator: (value){
        if(conformPasswordEditingController.text != passwordEditingController.text ) // for checking both are equal or not
        {
          return "Password Doesn't match";
        }
        return null;
      },
      onSaved: (value){ // function which store saved value
        conformPasswordEditingController.text = value!; // checking text entered by user is same or not
      },// for adding email address only in it
      textInputAction: TextInputAction.done, // for moving on to next field after next button in keyboard
      decoration: InputDecoration( // for decorating field in this box
        prefixIcon: Icon(Icons.vpn_key,color: Colors.deepPurpleAccent), // for password icon
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password", // for hint text
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

    // signup button
    final SignUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color:Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width, // for setting its  min width of column size
        onPressed: () {
          SignUp(emailEditingController.text,passwordEditingController.text); // passing email and id to Signup function

        },
        child: Text("SignUp",textAlign: TextAlign.center,
            style:TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold
            )),
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // for transparent
        elevation: 0,
        leading: IconButton(
          iconSize: 30,
          icon: Icon(Icons.arrow_back,
          color: Colors.white),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          )
        ),// for image


      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient( // for changing background color of app
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
                      SizedBox(height: 45,),
                      firstnNameField,
                      SizedBox(height: 20,),
                      secondNameField,
                      SizedBox(height: 20,),
                      emailField,
                      SizedBox(height: 20,),
                      passwordField,
                      SizedBox(height: 20,),
                      conformPasswordField,
                      SizedBox(height: 20,),
                      SignUpButton,
                      SizedBox(height: 15,)
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
  // function for SignUp (registering user to database)

void SignUp(String email,String password) async
{
  if(_formKey.currentState!.validate()){
   await _auth.createUserWithEmailAndPassword(email: email, password: password)
       .then((value) => {
         postDetailsToFirestore()
   }).catchError((e){
     Fluttertoast.showToast(msg: e!.message); // for showing toast message if error occured
   });
  }
}

postDetailsToFirestore() async {
    // calling our Firestore
   // calling our user model
   // sending these values

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance; // for calling our firestore
  User? user = _auth.currentUser; // for storing user

  UserModel userModel = UserModel(); // calling our user model

  //writing all the values to database
  userModel.email = user!.email; //for storing value in email
  userModel.uid = user.uid;  //for storing value in uid
  userModel.firstName = firstNameEditingController.text;
  userModel.secondName = secondNameEditingController.text;

  // for sending these values to fire store
  await firebaseFirestore
       .collection("users")
       .doc(user.uid)
       .set(userModel.toMap());
  Fluttertoast.showToast(msg: "Account created successfully : ");

  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()),
          (route) => false);// for moving to home screen

}
}


