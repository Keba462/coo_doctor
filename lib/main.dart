import 'package:coo_doctor/Pages/login_page.dart';
import 'package:coo_doctor/Pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:coo_doctor/firebase_options.dart';

Future<void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options:DefaultFirebaseOptions.currentPlatform,
   );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
//final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
 MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Co_Doctor',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: LogIn()
    );
  }
}

