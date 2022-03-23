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
        title: Text('Home '),
         backgroundColor: Colors.purple,
        centerTitle: true,
        ),
        drawer:Drawer(
          child:ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child:Text('Home ${widget.user.email}'),
                decoration:BoxDecoration(
                  color: Colors.purple,
                )
              ),
              Divider(
                height:1,
                thickness:1,
              ),
              ListTile(
                leading:Icon(Icons.account_circle),
                title: Text('Profile'),
                onTap: (){
                  Navigator.pop(context);
                }, 
              ),
               ListTile(
                 leading:Icon(Icons.logout),
                title: Text('Logout'),
                onTap:(){ 
                  showBanner();
                  Navigator.pop(context);
                },
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
                 padding:EdgeInsets.all(20),
                 mainAxisSpacing: 10,
                 primary: false,
                 children:<Widget>[
                   Container(
                     width:200,
                     height:200,
                      padding: EdgeInsets.all(8),
                  child:Card(
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
                   ),
                   Container(
                      width:200,
                     height:200,
                      padding: EdgeInsets.all(8),
                    child:Card(
                     elevation:2,
                     child:Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                     children:<Widget>[  
                   CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 48.0,
                  child: Image.asset('assets/comm.png'),
                ),
                Text('Communication')
                     ]
                     )
                   ), 
                   color:Colors.purple,
                   ),
                   Container(
                      width:200,
                     height:200,
                     padding: EdgeInsets.all(8),
                    child:Card(
                     elevation:2,
                     child:Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                     children:<Widget>[  
                   CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 48.0,
                  child: Image.asset('assets/feedback.png'),
                ),
                Text('Testing')
                     ]
                     )
                   ), 
                   ),Container(
                      width:200,
                     height:200,
                      padding: EdgeInsets.all(8),
                    child:Card(

                     elevation:2,
                     child:Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                     children:<Widget>[  
                   CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 48.0,
                  child: Image.asset('testing.png'),
                ),
                Text('Reports')
                     ]
                     )
                   ), 
                   ),
                   Container(
                      width:200,
                     height:200,
                      padding: EdgeInsets.all(8),
                    child:Card(
                     elevation:2,
                     child:Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                     children:<Widget>[  
                   CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 48.0,
                  child: Image.asset('assets/reports.png'),
                ),
                Text('Location')
                     ]
                     )
                   ), 
                   ),
                   Container(
                      width:200,
                     height:200,
                      padding: EdgeInsets.all(8),
                    child:Card(
                     elevation:2,
                     child:Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                     children:<Widget>[  
                   CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 48.0,
                  child: Image.asset('assets/location.png'),
                ),
                Text('Advice')
                     ]
                     )
                   ), 
                   ),
                  
                 ],
                 crossAxisCount: 2
                 ) ,
                )
              ],
                
            )
            

          ],
          ),
      
          bottomNavigationBar:BottomNavigationBar(
            backgroundColor:Colors.purple,
            selectedItemColor:Colors.white,
            unselectedItemColor:Colors.white.withOpacity(.60),
            items:<BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                ),
                 BottomNavigationBarItem(
                icon: Icon(Icons.library_books),
                label: 'Protocols',
                ),
                 BottomNavigationBarItem(
                icon: Icon(Icons.mail),
                label: 'Messages',
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
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
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