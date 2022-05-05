import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'feedback_chat.g.dart';

// After Completing run this command: flutter pub run build_runner build

@JsonSerializable()
class FeedbackChat{
  final String messageContent;
  final int messageType;
  String idTo;
  String idFrom;
   String timestamp;
  FeedbackChat({required this.messageContent, required this.messageType, required this.idFrom,required this.idTo,  required this.timestamp});

  factory FeedbackChat.fromDocument(DocumentSnapshot documentSnapshot) {
    String idFrom = documentSnapshot.get('idFrom');
    String idTo = documentSnapshot.get('idTo');
    String timestamp = documentSnapshot.get('timestamp');
    String content = documentSnapshot.get('messageContent');
    int type = documentSnapshot.get('messageType');

    return FeedbackChat(
        idFrom: idFrom,
        idTo: idTo,
        timestamp: timestamp,
        messageContent: content,
        messageType: type);
  }

  factory FeedbackChat.fromJson(Map<String, dynamic> json) => _$FeedbackChatFromJson(json);
  Map<String, dynamic> toJson() =>_$FeedbackChatToJson(this);

}
