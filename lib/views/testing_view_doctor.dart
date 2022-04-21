import 'package:flutter/material.dart';

class TestingViewDoctor extends StatefulWidget {
  const TestingViewDoctor({Key? key}) : super(key: key);

  @override
  State<TestingViewDoctor> createState() => _TestingViewDoctorState();
}

class _TestingViewDoctorState extends State<TestingViewDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Tests'),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
