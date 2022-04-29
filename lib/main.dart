import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coo_doctor/Pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:coo_doctor/firebase_options.dart';
import 'package:coo_doctor/utils/color_utils.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';
import 'package:coo_doctor/utils/imageWidget.dart';
import '../views/views.dart';

Future<void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options:DefaultFirebaseOptions.currentPlatform,
   );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
 MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        Provider<MessagesProvider>(
            create: (_) => MessagesProvider(firebaseFirestore: firebaseFirestore)),
        Provider<ChatProvider>(
            create: (_) => ChatProvider(
                firebaseFirestore: firebaseFirestore))
      ],
      child: MaterialApp(
      title: 'Co_Doctor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomPage()
      )
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
        width:MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height,
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
                   const Text('Co-Doctor is an application which makes life easier in this Covid-19 Era So enjoy!!!',style:TextStyle(fontSize: 14,color: Colors.white),),
                   const SizedBox(
                     height:30,
                   ),
                   ElevatedButton(
                      
                    onPressed:(){
                       Navigator.push(context, MaterialPageRoute(builder: (context) => const LogIn()));
                    }, 
                    child: const Text('Welcome'),
                   style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: const Size(500, 70)
            
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

