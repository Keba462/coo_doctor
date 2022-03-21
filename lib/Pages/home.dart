import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coo_doctor/Pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_svg/flutter_svg.dart';
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
        drawer:Drawer(
          child:ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child:Text('Drawer Header'),

                decoration:BoxDecoration(
                  color: Colors.purple,
                )
              ),
              ListTile(
                title: Text('Profile'),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
               ListTile(
                title: Text('Logout'),
                onTap: showBanner,
              )
            ],
          )
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
                   Card(
                     elevation:2,
                     child:Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                     children:<Widget>[  
                   CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 48.0,
                  child: Image.asset('assets/knowledge.png'),
                ),
                Text('Knowledge')
                     ]
                     )
                   ),
                    Card(
                     elevation:2,
                     child:Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                     children:<Widget>[  
                   CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 48.0,
                  child: Image.asset('assets/knowledge.png'),
                ),
                Text('Knowledge')
                     ]
                     )
                   ), Card(
                     elevation:2,
                     child:Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                     children:<Widget>[  
                   CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 48.0,
                  child: Image.asset('assets/knowledge.png'),
                ),
                Text('Knowledge')
                     ]
                     )
                   )
                 ],
                 crossAxisCount: 2
                 ) ,
                )
              ],
                
            )
            

          ],
          ),
      
          bottomNavigationBar:BottomNavigationBar(
            items:<BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                ),
                 BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Protocols',
                ),
                 BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Notifications',
                ),
                
            ]
          )
    );
    List<Widget>_widgetOptions = <Widget>[

    ] ;
  }
  void showBanner()=>ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
      backgroundColor:Colors.white,
      padding: EdgeInsets.all(18),
      content: Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          style: TextButton.styleFrom(primary: Colors.purple),
          onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>LogIn()));
          }, 
          child: Text('YES'),
          ),
          TextButton(
          style: TextButton.styleFrom(primary: Colors.purple),
          onPressed:() =>
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
          
          child: Text('NO'))
      ]

    )
  );
}