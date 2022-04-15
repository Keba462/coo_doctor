import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({Key? key}) : super(key: key);

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  String? _emailsender, _emailreceiver, _feedback;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(
    title:const Text('Feedback'),
      backgroundColor: Colors.purple,
      centerTitle: true,
    ),
      body:Form(
        key: _formkey,
        child: Column(children: <Widget>[
          const SizedBox(
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
            onSaved: (input) => _emailsender = input!,
            decoration: InputDecoration(
              labelText: 'YourEmail',
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.purple,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            validator: (input) {
              if (input == "" ||
                  !RegExp(r'^[A-Za-z0-9]+@([\w-]+\.)+[\w-]{2,}$')
                      .hasMatch(input!)) {
                return 'please type in correct email address';
              }
            },
            onSaved: (input) => _emailreceiver = input!,
            decoration: InputDecoration(
              labelText: 'ReceiversEmail',
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.purple,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            validator: (input) {
              if (input == "" ||
                  !RegExp(r'^[A-Za-z0-9]{1,100}').hasMatch(input!)) {
                return 'Message must be atleast a character long but not more than 100 characters';
              }
            },
            onSaved: (input) => _feedback = input!,
            decoration: InputDecoration(
              labelText: 'Feedback',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 40)
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: sendFeedback,
            child: const Text('Send'),
            style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                minimumSize: const Size(200, 50)),
          ),
        ]
        )
      )
    );
  }

  Future<void> sendFeedback() async {
    final formState = _formkey.currentState;
    if (formState!.validate()) {
      formState.save();
    }
    try {
      await FirebaseFirestore.instance.collection('feedback').doc().set({
        "SenderEmail": _emailsender,
        "ReceiverEmail": _emailreceiver,
        "Message": _feedback,
      });
      if (kDebugMode) {
        print('Sent Feedback');
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MessagesView()));
    } catch (e) {
      print(e);
    }
  }
}
