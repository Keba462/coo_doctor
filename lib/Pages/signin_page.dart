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
  bool _obscureText= true;
  String _role ='Patient';
 String? _email,_password,_idnumber,_names;
String title ="Role";

 TextEditingController password =TextEditingController();
 TextEditingController confirmpassword=TextEditingController();
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
               labelText: 'Idnmuber',prefixIcon: Icon(Icons.person,color: Colors.purple,),
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
               labelText: 'Names',prefixIcon: Icon(Icons.person,color: Colors.purple,),
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
               labelText: 'Email',prefixIcon: Icon(Icons.person,color: Colors.purple,),
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
             ),
            
           ),
           SizedBox(
             height: 20.0,
           ),
           /*
           TextFormField(
             validator:(input) {
               if(input == ""){
                 return 'please type in Your Role';
               }
             },
             onSaved:(input) => _role= input!,
             decoration: InputDecoration(
               labelText: 'patient/doctor',prefixIcon: Icon(Icons.person_outlined,color: Colors.purple,),
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
             ),
            
           ),
          */
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
               if(input ==""){
                 return 'please re-enter password';
               }
               print(password.text);
               print(confirmpassword.text);
               if(password.text!=confirmpassword.text){
                 return "passwords are not a match";
               }
               return null;

             },
             onSaved:(input) =>_password = input! ,
             obscureText:_obscureText,
             decoration: InputDecoration(
               labelText: 'Confirm Password',prefixIcon: Icon(Icons.lock_outlined,color: Colors.purple,),
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
               suffixIcon:IconButton(
            icon:Icon(
              _obscureText ? Icons.visibility :Icons.visibility_off),
              onPressed:(){
                setState((){
                  _obscureText =!_obscureText;
                });
              }),
            ),
             
        ),
           SizedBox(
             height: 10.0,
           ),
           /*
           ExpansionTile(
             title:Text(title),
             subtitle: Text('Select a Role'),
             children:<Widget>[
               ListTile(
                 title:Text('Doctor')),
                 ListTile(
                 title:Text('Patient'))
             ]
             ),*/
      DropdownButton<String>(
      value: _role,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          _role = newValue!;
        });
      },
      items: <String>['Patient', 'Doctor']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
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
       FirebaseFirestore.instance.collection('users').doc().set({"email":_email,"password":_password,"idnumber":_idnumber,"full names":_names,"role":_role},);
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