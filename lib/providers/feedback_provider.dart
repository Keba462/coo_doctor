import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';

class ChatProvider {
  final FirebaseFirestore firebaseFirestore;


  ChatProvider(
      {
        required this.firebaseFirestore});



  Future<void> updateFirestoreData(
      String collectionPath, String docPath, Map<String, dynamic> dataUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataUpdate);
  }

  Stream<QuerySnapshot> getFeedbackMessage(String groupChatId, int limit) {
    return firebaseFirestore
        .collection("messages")
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy("timestamp", descending: true)
        .limit(limit)
        .snapshots();
  }

  void sendFeedbackMessage(String content, int type, String groupChatId,
      String currentUserId, String peerId) {
    DocumentReference documentReference = firebaseFirestore
        .collection("feedback")
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    FeedbackChat feedbackMessages = FeedbackChat(
        idFrom: currentUserId,
        idTo: peerId,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        messageContent: content,
        messageType: type);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, feedbackMessages.toJson());
    });
  }
}

class MessageType {
  static const text = 0;
  static const image = 1;
  static const sticker = 2;
}