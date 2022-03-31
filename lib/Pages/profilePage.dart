import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coo_doctor/Pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coo_doctor/utils/provider_widget.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({ Key? key,required this.user }) : super(key: key);
final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        backgroundColor: Colors.purple
      ),
      body:StreamBuilder<DocumentSnapshot>(stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),

      builder:(BuildContext context,AsyncSnapshot<DocumentSnapshot>snapshot){
        if(snapshot.hasError){
          return Text('Error :${snapshot.error}');
        }
        return  Text(snapshot.data!['idnumber']);
      }
      ),
    );
  }
}

/*
class ProfilePage extends StatefulWidget {

  const ProfilePage(
  { Key? key}) : super(key: key);
  
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

 @override
  Widget build(BuildContext context) {
    var user;
    return SingleChildScrollView(
      child:Container(
        width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future:Provider.of(context).auth.getCurrentUser(),
            builder: (context,snapshot){
              if(snapshot.connectionState ==ConnectionState.done){
                return displayUserInformation(context,snapshot);
              }else{
                return CircularProgressIndicator();
              }
            },
            )

        ]
        ),

      )
      
    );
  }
 Widget displayUserInformation(context,snapshot){
   final user =snapshot.data;
   return Column(
     children: <Widget>[
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Text("Name $user.full names}",style: TextStyle(fontSize: 20.0),),
         ),
         Padding(
         padding: const EdgeInsets.all(8.0),
         child: Text("Omang/Passportno:$user.idnummber}",style: TextStyle(fontSize: 20.0),),
         ),
         Padding(
         padding: const EdgeInsets.all(8.0),
         child: Text("Email $user.email}",style: TextStyle(fontSize: 20.0),),
         ),
         Padding(
         padding: const EdgeInsets.all(8.0),
         child: Text("Password $user.password}",style: TextStyle(fontSize: 20.0),),
         ),
         
     ],
   );
 }
}*/
