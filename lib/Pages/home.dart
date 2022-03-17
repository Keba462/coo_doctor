import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
class HomePage extends StatefulWidget {
  const HomePage(
    { Key? key ,required this.user}) : super(key: key);
  final User user;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home ${widget.user.email}'),
         backgroundColor: Colors.purple,
        centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
               child:GridView.count(
                 crossAxisSpacing:10,
                 mainAxisSpacing: 10,
                 primary: false,
                 children:<Widget>[
                   SvgPicture.asset('assets/svg/knowlege.svg',height: 128,),
                   Text('Knowledge')
                 ],
                 crossAxisCount: 2
                 ) ,
                )
              ],
                
            )
            

          ],
          ),
    ); 
  }
}