import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/covid_user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>  with SingleTickerProviderStateMixin {

  final CollectionReference users = FirebaseFirestore.instance.collection(
      'users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  final TextEditingController _nameTextController = TextEditingController();
late String _names;
CovidUser? covidUser;

@override
  void initState() {
   getProfileInfo();
  _status = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile '),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions:  [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(icon: const Icon(Icons.edit), onPressed: (){onEditPressed();}
            ,),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Column(children: <Widget>[
              displayUserInformation()
            ]),
          )),
    );
  }

  Widget displayUserInformation() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _nameTextController,
            decoration: const InputDecoration(
              hintText: 'Full names',
              labelText: 'Full Names',
             border: OutlineInputBorder( ),
            ),
            enabled: !_status,
            autofocus: !_status,
            onChanged: (text) {
              _names = text;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Omang/Passportno: ${covidUser!.omang}",
            style: const TextStyle(fontSize: 20.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Email: ${covidUser!.email}",
            style: const TextStyle(fontSize: 20.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Role: ${covidUser!.role}",
            style: const TextStyle(fontSize: 20.0),
          ),
        ),

        !_status ? _getActionButtons() : Container(),

      ],
    );
  }


  Future<void> getProfileInfo() async {
    return await users.doc(_auth.currentUser!.uid)
        .withConverter<CovidUser>(
      fromFirestore: (snapshots, _) => CovidUser.fromJson(snapshots.data()!),
      toFirestore: (covidUser, _) => covidUser.toJson(),).get().then((value) {
      if (kDebugMode) {
        print('UserID: ${_auth.currentUser!.uid}');
        print("Data: ${value.data().toString()}");
      }
setState(() {
  covidUser = CovidUser.fromJson(value.data()!.toJson());
  _nameTextController.text = covidUser!.fullName;
});

    });
  }

  Widget showNameInput() {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _nameTextController,
                decoration: const InputDecoration(
                  hintText: 'Full names',
                  labelText: 'Full Names',
                  border: OutlineInputBorder(),
                ),
                enabled: !_status,
                autofocus: !_status,
                onChanged: (text) {
                  _names = text;
                },
              ),
            ),
          ],
        ));
  }

  Widget _getActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ElevatedButton(
                child: const Text("Save"),
                 style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                minimumSize: const Size(200, 50)),
                onPressed: () {
                  setState(() {
                    _status = true;
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(_auth.currentUser!.uid).set(covidUser!.toJson()).whenComplete(() => print('Complete')).onError((error, stackTrace) => print("Could not complete"));

                    // UserUpdateInfo info = UserUpdateInfo();

                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ElevatedButton(
                child: const Text("Cancel"),
                 style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                minimumSize: const Size(200, 50)),
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
              ),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  onEditPressed() {
    setState(() {
      _status = false;
    });

    void disposeControllers() {
      _nameTextController.dispose();
    }


    @override
    void dispose() {
      // Clean up the controller when the Widget is disposed
      myFocusNode.dispose();
      disposeControllers();
      super.dispose();
    }
  }
}
