import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coo_doctor/views/messages_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'messages_view.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _limit = 20;
  final int _limitIncrement = 20;
  final ScrollController scrollController = ScrollController();

  late MessagesProvider messageProvider;

  @override
  void initState() {
    messageProvider = context.read<MessagesProvider>();
    scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
         backgroundColor: Colors.purple,
        centerTitle: true,
    
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: messageProvider.getFirestoreData("users",_limit),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if ((snapshot.data?.docs.length ?? 0) > 0) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => buildItem(
                    context, snapshot.data?.docs[index]),
                controller: scrollController,
                separatorBuilder:
                    (BuildContext context, int index) =>
                const Divider(),
              );
            } else {
              return const Center(
                child: Text('No user found...'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }



  Widget buildItem(BuildContext context, DocumentSnapshot? documentSnapshot) {
    final firebaseAuth = FirebaseAuth.instance;
    if (documentSnapshot != null) {
      CovidUser userChat = CovidUser.fromDocument(documentSnapshot);
      if (userChat.userId == FirebaseAuth.instance.currentUser!.uid) {
        return const SizedBox.shrink();
      } else {
        return TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MessagesView(
                      peerId: userChat.userId,
                      peerNickname: userChat.fullName,
                    )));
          },
          child: ListTile(
            leading:  const Icon(
              Icons.account_circle,
              color:Colors.black,
              size: 50,
            ),
            title: Text(
              userChat.fullName,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }



  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }
}

class MessagesProvider {
  final FirebaseFirestore firebaseFirestore;

  MessagesProvider({required this.firebaseFirestore});

  Future<void> updateFirestoreData(
      String collectionPath, String path, Map<String, dynamic> updateData) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(path)
        .update(updateData);
  }

  Stream<QuerySnapshot> getFirestoreData(
      String collectionPath, int limit) {
      return firebaseFirestore
          .collection(collectionPath)
          .limit(limit)
          .snapshots();

  }
}