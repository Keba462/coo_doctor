import 'dart:ui';

import 'package:coo_doctor/Pages/forgot_pass.dart';
import 'package:coo_doctor/Pages/home.dart';
import 'package:coo_doctor/views/HomeView.dart';
import 'package:flutter/material.dart';
import 'package:coo_doctor/Pages/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coo_doctor/Pages/Landing_Page.dart';
class LogIn extends StatefulWidget {
  const LogIn({ Key? key }) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _obscureText =true;
  late String _email,_password,_error,_success;
  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            SizedBox(
          height: 50.0,
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
             height: 30.0,
           ),
           TextFormField(
             validator: (input){
               if(input == ""){
                 return 'please type password';
               }
             },
             onSaved:(input) =>_password = input! ,
             obscureText:_obscureText,
             decoration: InputDecoration(
               labelText: 'Password',prefixIcon: Icon(Icons.lock_outlined,color: Colors.purple,),
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
        TextButton(
                child: Text('Forgot Password'),
                 style: TextButton.styleFrom(
                  primary: Colors.purple,
            
                       ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPage()));
                              }
        ),
           
           SizedBox(
             height: 30.0,
           ),
  
           ElevatedButton(
             
             onPressed:logIn , 
             child: Text('login'),
             style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              minimumSize: Size(200, 50)
            
                       ),
             ),
             SizedBox(
               height: 20.0,
             ),
             

        SizedBox(
          height: 50.0,
        ),
        Row (
          mainAxisAlignment: MainAxisAlignment.center, 
          children:<Widget>[
            Text('Dont have an Account?',
            style: TextStyle(color: Colors.purple),),

        OutlinedButton(
              onPressed: () {
      // Respond to button press
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
           },
         child: Text("SignIn"),
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


  Widget ShowAlert(){
    if(_error != ""){
    return Container(
      color:Colors.purpleAccent,
      width:double.infinity,
      padding:EdgeInsets.all(8.0),
      child:Row(
        children:<Widget>[
          Padding(
            padding:EdgeInsets.only(right:8.0),
            child:Icon(Icons.error_outline),
          ),
          Expanded(child:Text(_error,maxLines:3),),
          Padding(
            padding:EdgeInsets.only(right:8.0),
         child: IconButton(
            icon:Icon(Icons.close),
            onPressed:(){
              setState((){
                _error= "";
              });
            },
         ),
          ),
        ]
      )
    );
    }
    return Container(
      color:Color.fromARGB(255, 162, 158, 163),
      width:double.infinity,
      padding:EdgeInsets.all(8.0),
      child:Row(
        children:<Widget>[
          Icon(Icons.error_outline),
        ]
        ),
    );
    
  }
  Future<void> logIn () async{
    final formState =_formkey.currentState;
      if(formState!.validate()){
      formState.save();
      try{
     UserCredential result =await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      User? user =result.user;
      // ignore: prefer_const_constructors
      setState((){
      _success="Successfully logged in";
      }
      );
      
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      } on FirebaseAuthException catch(e){
        print(e);
        setState((){
          _error='${e.message}';
        });
        print('Failed with error code: ${e.code}');
        
      }
    }
  }

}