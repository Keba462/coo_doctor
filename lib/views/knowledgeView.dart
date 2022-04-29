import 'package:flutter/material.dart';

class KnowledgeView extends StatefulWidget {
  const KnowledgeView({ Key? key }) : super(key: key);

  @override
  State<KnowledgeView> createState() => _KnowledgeViewState();
}

class _KnowledgeViewState extends State<KnowledgeView> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: const Text('Knowledge'),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
