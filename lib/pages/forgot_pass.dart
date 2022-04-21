import 'package:coo_doctor/Pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  String? _email;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
          backgroundColor: Colors.purple,
          centerTitle: true,
        ),
        body: Form(
            key: _formkey,
            child: Column(children: <Widget>[
              const SizedBox(
                height: 50.0,
              ),
              TextFormField(
                validator: (input) {
                  if (input == "") {
                    return 'please type your email';
                  }
                },
                onSaved: (input) => _email = input!,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(
                    Icons.person_outlined,
                    color: Colors.purple,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: resetPassword,
                child: const Text('Reset Password'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: const Size(200, 50)),
              ),
            ])));
  }

  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email ?? "");
      if (kDebugMode) {
        print('password Reset Email Sent');
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LogIn()));
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
      }
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
