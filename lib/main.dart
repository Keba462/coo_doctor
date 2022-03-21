import 'package:coo_doctor/Pages/login_page.dart';
import 'package:coo_doctor/Pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:coo_doctor/firebase_options.dart';
import 'package:coo_doctor/utils/color_utils.dart';
import 'package:coo_doctor/utils/imageWidget.dart';
Future<void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options:DefaultFirebaseOptions.currentPlatform,
   );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

 MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Co_Doctor',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: WelcomPage()
    );
  }
}

class WelcomPage extends StatefulWidget {
  const WelcomPage({ Key? key }) : super(key: key);

  @override
  State<WelcomPage> createState() => _WelcomPageState();
}

class _WelcomPageState extends State<WelcomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:
           [hexStringToColor("#9900CC"),
           hexStringToColor("#FFFFFF")],begin:Alignment.topCenter,end:Alignment.bottomCenter)),
           child:SingleChildScrollView(
             child: Padding(
               padding:EdgeInsets.fromLTRB(
                 20,MediaQuery.of(context).size.height *0.2,20,0),
               child:Column(
                 children:<Widget>[
                   logoWidget("assets/logo.png"),
                   SizedBox(
                     height:30,
                   ),
                   ElevatedButton(
                      
                    onPressed:(){
                       Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
                    }, 
                    child: Text('Welcome'),
                   style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(500, 70)
            
                       ),
                   )
                 ]
               )
             )
           )
      ),
      
    );
  }
}

