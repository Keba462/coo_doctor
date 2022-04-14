import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  String? _email, _issue;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
        backgroundColor: Colors.purple,
      ),
      body: Form(
          key: _formkey,
          child: Column(children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              validator: (input) {
                if (input == "" ||
                    !RegExp(r'^[A-Za-z0-9]+@([\w-]+\.)+[\w-]{2,}$')
                        .hasMatch(input!)) {
                  return 'please type in correct email address';
                }
              },
              onSaved: (input) => _email = input!,
              decoration: InputDecoration(
                labelText: 'YourEmail',
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.purple,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              validator: (input) {
                if (input == "" ||
                    !RegExp(r'^[A-Za-z0-9]{1,100}').hasMatch(input!)) {
                  return 'Describe your issue in less than 100 charcters';
                }
              },
              onSaved: (input) => _issue = input!,
              decoration: InputDecoration(
                labelText: 'issue',
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.purple,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: sendReport,
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(200, 50)),
            ),
          ])),
    );
  }

  Future<void> sendReport() async {
    final formState = _formkey.currentState;
    if (formState!.validate()) {
      formState.save();
    }
    try{
      await  FirebaseFirestore.instance.collection('reports').doc().set({"Email":_email,"Issue":_issue,});
       print('Sent Report');
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ReportsPage()));
    }catch(e){
        print(e);

    }
  }
}
