import 'package:flutter/material.dart';

import '../Pages/pages.dart';
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
        title: const Text('Home '),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              child: Text('Home'),
              decoration: BoxDecoration(
                color: Colors.purple,
              )),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
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
                    padding: const EdgeInsets.all(20),
                    mainAxisSpacing: 10,
                    primary: false,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        padding: const EdgeInsets.all(8),
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
                                      child: const Text('Knowledge'),
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
                        padding: const EdgeInsets.all(8),
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
                                      child: const Text('Testing'),
                                      style: TextButton.styleFrom(
                                        primary: Colors.purple,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TestingViewPatient()));
                                      }),
                                ])),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        padding: const EdgeInsets.all(8),
                        child: Card(
                            elevation: 2,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 48.0,
                                    child: Image.asset('assets/reports.png'),
                                  ),
                                  TextButton(
                                      child: const Text('Reports'),
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
                        padding: const EdgeInsets.all(8),
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
                                      child: const Text('Location'),
                                      style: TextButton.styleFrom(
                                        primary: Colors.purple,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Map()));
                                      }),
                                ])),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        padding: const EdgeInsets.all(8),
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
                                      child: const Text('Settings'),
                                      style: TextButton.styleFrom(
                                        primary: Colors.purple,
                                      ),
                                      onPressed: () {
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                                      }),
                                ])),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        padding: const EdgeInsets.all(8),
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
                                      child: const Text('Help'),
                                      style: TextButton.styleFrom(
                                        primary: Colors.purple,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Map()));
                                      }),
                                ])),
                      ),
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
          padding: const EdgeInsets.all(18),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(primary: Colors.purple),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LogIn()));
              },
              child: const Text('YES'),
            ),
            TextButton(
                style: TextButton.styleFrom(primary: Colors.purple),
                onPressed: () =>
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                child: const Text('NO'))
          ]));
}
