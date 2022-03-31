
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:coo_doctor/Pages/login_page.dart';
import 'package:coo_doctor/Pages/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandingPage extends StatefulWidget {
  const LandingPage(
     { Key? key ,required this.user}) : super(key: key);
   final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homey,${user.email}'),
         backgroundColor: Colors.purple,
        centerTitle: true,
        ),
        body: StreamBuilder<DocumentSnapshot>(stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
        builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot>snapshot){
          if(snapshot.hasError){
            return Text('Error:${snapshot.error}');
          }
          switch(snapshot.connectionState){
            case ConnectionState.waiting: return Text('Loading..');
            default:
            return Text(snapshot.data!['role'] );
          }

        },
        ),     
    );
  }
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  
  //@override
  Widget build(BuildContext context) {
    return Container(

    );
  }
  
}