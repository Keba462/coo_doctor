import 'dart:ui';

import 'package:coo_doctor/Pages/home.dart';
import 'package:coo_doctor/Pages/login_page.dart';
import 'package:coo_doctor/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignUp extends StatefulWidget {
  const SignUp({ Key? key }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
 String? _email,_password,_idnumber,_names;
  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 48.0,
                  child: Image.asset('assets/logo.png'),
                ),
            SizedBox(
             height: 10.0,
           ),
           TextFormField(
             validator:(input) {
               if(input == ""){
                 return 'please type Idnumber';
               }
             },
             onSaved:(input) => _idnumber = input!,
             decoration: InputDecoration(
               labelText: 'Idnmuber',prefixIcon: Icon(Icons.person_outlined,color: Colors.purple,),
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
             ),
            
           ),
           SizedBox(
             height: 20.0,
           ),
           TextFormField(
             validator:(input) {
               if(input == ""){
                 return 'please type Fullname';
               }
             },
             onSaved:(input) => _names = input!,
             decoration: InputDecoration(
               labelText: 'Names',prefixIcon: Icon(Icons.person_outlined,color: Colors.purple,),
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
             ),
            
           ),
           SizedBox(
             height: 20.0,
           ),
           TextFormField(
             validator:(input) {
               if(input == ""){
                 return 'please type Email';
               }
             },
             onSaved:(input) => _email = input!,
             decoration: InputDecoration(
               labelText: 'Email',prefixIcon: Icon(Icons.person_outlined,color: Colors.purple,),
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
             ),
            
           ),
           SizedBox(
             height: 20.0,
           ),
           TextFormField(
             validator: (input){
               if(input == ""){
                 return 'please type password';
               }
             },
             onSaved:(input) =>_password = input! ,
             decoration: InputDecoration(
               labelText: 'Password',
               prefixIcon: Icon(Icons.lock_outlined,color: Colors.purple,),
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
             ),
             obscureText: true,
           ),
           SizedBox(
             height: 20.0,
           ),
           TextFormField(
             validator: (input){
               if(input == ""){
                 return 'Passwords do not match';
               }
             },
             onSaved:(input) =>_password = input! ,
             decoration: InputDecoration(
               labelText: 'Confirm Password',
               prefixIcon: Icon(Icons.lock_outlined,color: Colors.purple,),
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
             ),
             obscureText: true,
           ),
           SizedBox(
             height: 20.0,
           ),
  
           ElevatedButton(
             
             onPressed:signUp , 
             child: Text('Sign up'),
             style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              minimumSize: Size(200, 50)
            
                       ),
             ),
        SizedBox(
          height: 10.0,
        ),
        Row (
          mainAxisAlignment: MainAxisAlignment.center, 
          children:<Widget>[
            Text('Already have an Account?',
            style: TextStyle(color: Colors.purple),),

        OutlinedButton(
              onPressed: () {
      // Respond to button press
      Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
           },
         child: Text("login"),
         style: OutlinedButton.styleFrom(
                  primary: Colors.purple,
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0))
                       ),
                
              )

          ]
        )
          ]
          ),
      ),
      
    );
  }
  Future<void> signUp () async{
    final formState =_formkey.currentState;
      if(formState!.validate()){
      formState.save();
      try{
     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email??"", password: _password??"").then((value){
       FirebaseFirestore.instance.collection('patients').doc().set({"email":_email,"password":_password,"idnumber":_idnumber,"full names":_names},);
       print('created new account');
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn()));
     });
      //user!.sendEmailVerification();
      // ignore: prefer_const_constructors
      
      } on FirebaseAuthException catch(e){
        print('Failed with error code: ${e.code}');
        print(e);
      }
    }
  }
}