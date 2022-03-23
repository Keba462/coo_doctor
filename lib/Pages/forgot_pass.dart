import 'package:flutter/material.dart';
import 'package:coo_doctor/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:coo_doctor/Pages/login_page.dart';
import 'package:coo_doctor/Pages/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({ Key? key }) : super(key: key);

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
   String? _email;
   final GlobalKey<FormState>_formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
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
                 return 'please type your email';
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
  
           ElevatedButton(
             onPressed:resetPassword , 
             child: Text('Reset Password'),
             style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              minimumSize: Size(200, 50)
            
                       ),
             ),
           
           ]
        )
      )
    );
  }
  Future <void> resetPassword()  async{
    try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _email??"");
    print('password Reset Email Sent');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn()));
    } on FirebaseAuthException catch(e){
        print('Failed with error code: ${e.code}');
        print(e);
    }
  }
}