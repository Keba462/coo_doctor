import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:coo_doctor/Pages/login_page.dart';
import 'package:coo_doctor/views/testingViewPatient.dart';
import 'package:coo_doctor/views/locationView.dart';
import 'package:coo_doctor/Pages/profilePage.dart';
>>>>>>> e7fa4c26dd62348122bffba97893378fffe54ce7
import 'package:firebase_auth/firebase_auth.dart';

import '../Pages/pages.dart';
import 'settings/settings.dart';
import 'views.dart';

class HomeView extends StatefulWidget {
  HomeView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home '),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              child: Text('Home'),
              decoration: BoxDecoration(
                color: Colors.purple,
              )),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              showBanner();
              Navigator.pop(context);
            },
          )
        ],
      )),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: GridView.count(
                    crossAxisSpacing: 10,
                    padding: EdgeInsets.all(20),
                    mainAxisSpacing: 10,
                    primary: false,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.all(8),
                        child: Card(
                            elevation: 2,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 48.0,
                                    child: Image.asset('assets/knowledge.png'),
                                  ),
                                  TextButton(
                                      child: Text('Knowledge'),
                                      style: TextButton.styleFrom(
                                        primary: Colors.purple,
                                      ),
                                      onPressed: () {
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPage()));
                                      }),
                                ])),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.all(8),
                        child: Card(
                            elevation: 2,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 48.0,
                                    child: Image.asset('assets/testing.png'),
                                  ),
                                  TextButton(
                                      child: Text('Testing'),
                                      style: TextButton.styleFrom(
                                        primary: Colors.purple,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TestingViewPatient()));
                                      }),
                                ])),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.all(8),
                        child: Card(
                            elevation: 2,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 48.0,
                                    child: Image.asset('reports.png'),
                                  ),
                                  TextButton(
                                      child: Text('Reports'),
                                      style: TextButton.styleFrom(
                                        primary: Colors.purple,
                                      ),
                                      onPressed: () {
                                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPage()));
                                      }),
                                ])),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.all(8),
                        child: Card(
                            elevation: 2,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 48.0,
                                    child: Image.asset('assets/location.png'),
                                  ),
                                  TextButton(
                                      child: Text('Location'),
                                      style: TextButton.styleFrom(
                                        primary: Colors.purple,
                                      ),
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Map()));
                                      }),
                                ])),
                      ),
<<<<<<< HEAD
                      Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.all(8),
                        child: Card(
                            elevation: 2,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 48.0,
                                    child: Image.asset('assets/settings.png'),
                                  ),
                                  TextButton(
                                      child: Text('Settings'),
                                      style: TextButton.styleFrom(
                                        primary: Colors.purple,
                                      ),
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                                      }),
                                ])),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.all(8),
                        child: Card(
                            elevation: 2,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 48.0,
                                    child: Image.asset('assets/help.png'),
                                  ),
                                  TextButton(
                                      child: Text('Help'),
                                      style: TextButton.styleFrom(
                                        primary: Colors.purple,
                                      ),
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Map()));
                                      }),
                                ])),
                      ),
=======
>>>>>>> e7fa4c26dd62348122bffba97893378fffe54ce7
                    ],
                    crossAxisCount: 2),
              )
            ],
          )
        ],
      ),
    );
  }

  void showBanner() =>
      ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          backgroundColor: Colors.white,
          padding: EdgeInsets.all(18),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(primary: Colors.purple),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LogIn()));
              },
              child: Text('YES'),
            ),
            TextButton(
                style: TextButton.styleFrom(primary: Colors.purple),
                onPressed: () =>
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                child: Text('NO'))
          ]));
}
