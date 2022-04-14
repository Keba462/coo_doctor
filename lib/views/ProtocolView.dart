import 'package:coo_doctor/utils/imageWidget.dart';
import 'package:flutter/material.dart';

class ProtocolView extends StatefulWidget {
  const ProtocolView({Key? key}) : super(key: key);

  @override
  State<ProtocolView> createState() => _ProtocolViewState();
}

class _ProtocolViewState extends State<ProtocolView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid -19 Protocols'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    logoWidget("assets/mask.png"),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Wearing your mask is essential as it protects you from moisture particles that might cause an infection.',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))
                  ]),
            ),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    logoWidget("assets/hands.png"),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Regulaly bathing or sanitizing your hands kills the germs you come into contact with during your aily activities.',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))
                  ]),
            ),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  logoWidget("assets/distance.png"),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Keep a distance of one meter apart always.',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
                ]))
          ],
        ),
      ),
    );
  }
}
