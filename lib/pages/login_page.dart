import 'package:coo_doctor/Pages/forgot_pass.dart';
import 'package:coo_doctor/Pages/home.dart';
import 'package:coo_doctor/Pages/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _obscureText = true;
  late String _email, _password, _error, _success;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            const SizedBox(
              height: 50.0,
            ),
            TextFormField(
              validator: (input) {
                if (input == "") {
                  return 'please type Email';
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
              height: 30.0,
            ),
            TextFormField(
              validator: (input) {
                if (input == "") {
                  return 'please type password';
                }
              },
              onSaved: (input) => _password = input!,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: 'Password',
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
            TextButton(
                child: const Text('Forgot Password'),
                style: TextButton.styleFrom(
                  primary: Colors.purple,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPage()));
                }),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: logIn,
              child: const Text('login'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: const Size(200, 50)),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const SizedBox(
              height: 50.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const Text(
                'Dont have an Account?',
                style: TextStyle(color: Colors.purple),
              ),
              OutlinedButton(
                onPressed: () {
                  // Respond to button press
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                child: const Text("Signin"),
                style: OutlinedButton.styleFrom(
                    primary: Colors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              )
            ])
          ]),
        ),
      ),
    );
  }

  Future<void> logIn() async {
    final formState = _formkey.currentState;
    if (formState!.validate()) {
      formState.save();
      try {
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        User? user = result.user;

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Successful login'),
          backgroundColor: Colors.red.shade300,
        ));

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } on FirebaseAuthException catch (e) {
        if (kDebugMode) {
          print(e);
        }
        /*
        setState(() {
          _error = '${e.message}';
        });*/
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${e.message}'),
          backgroundColor: Colors.red.shade300,
        ));
        if (kDebugMode) {
          print('Failed with error code: ${e.code}');
        }
      }
    }
  }
}
