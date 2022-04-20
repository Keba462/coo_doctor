import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coo_doctor/Pages/login_page.dart';
import 'package:coo_doctor/models/covid_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _obscureText = true;
  String _role = 'Patient';
  late String _email, _password, _idnumber, _names;
  String title = "Role";

  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: Column(children: <Widget>[
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            validator: (input) {
              if (input == "" ||
                  !RegExp(r'^[0-9]{4}[1-2]{1}[0-9]{4}|[A-Z]{2}[0-9]{7}$')
                      .hasMatch(input!)) {
                return 'please correct Idnumber or passport number';
              }
            },
            onSaved: (input) => _idnumber = input!,
            decoration: InputDecoration(
              labelText: 'Idnmuber/PassportNo',
              prefixIcon: const Icon(
                Icons.person,
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
          TextFormField(
            validator: (input) {
              if (input == "" || !RegExp(r'^[A-Z a-z]+$').hasMatch(input!)) {
                return 'please type Fullname';
              }
            },
            onSaved: (input) => _names = input!,
            decoration: InputDecoration(
              labelText: 'Names',
              prefixIcon: const Icon(
                Icons.person,
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
          TextFormField(
            validator: (input) {
              if (input == "" ||
                  !RegExp(r'^[A-Za-z0-9]+@([\w-]+\.)+[\w-]{2,}$')
                      .hasMatch(input!)) {
                return 'please type in correct email address';
              }
            },
            onSaved: (input) => _email = input!,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(
                Icons.person,
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
          TextFormField(
            validator: (input) {
              if (input == "" ||
                  !RegExp(r'^[A-Za-z0-9]{9,}$').hasMatch(input!)) {
                return 'password must have at least nine characters';
              }
            },
            onSaved: (input) => _password = input!,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(
                Icons.lock_outlined,
                color: Colors.purple,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            obscureText: true,
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            validator: (input) {
              if (input == "") {
                return 'please re-enter password';
              }
              if (kDebugMode) {
                print(password.text);
              }
              if (kDebugMode) {
                print(confirmpassword.text);
              }
              if (password.text != confirmpassword.text) {
                return "passwords are not a match";
              }
              return null;
            },
            onSaved: (input) => _password = input!,
            obscureText: _obscureText,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: const Icon(
                Icons.lock_outlined,
                color: Colors.purple,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  }),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
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
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: signUp,
            child: const Text('Sign up'),
           
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            const Text(
              'Already have an Account?',
              style: TextStyle(color: Colors.purple),
            ),
            OutlinedButton(
              onPressed: () {
                // Respond to button press
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const LogIn()));
              },
              child: const Text("login"),
              style: OutlinedButton.styleFrom(
                  primary: Colors.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0))),
            )
          ])
        ]),
      ),
    );
  }

  Future<void> signUp() async {
    final formState = _formkey.currentState;
    if (formState!.validate()) {
      formState.save();
      try {
        //var firebaseUser = await FirebaseAuth.instance.currentUser!();
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _email, password: _password)
            .then((value) {
          FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set(
            CovidUser(omang: _idnumber, fullName: _names, email: _email, role: _role).toJson(),
          );
          if (kDebugMode) {
            print('created new account');
          }
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const LogIn()));
        });
        //user!.sendEmailVerification();
        // ignore: prefer_const_constructors

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
}
