// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackChat _$FeedbackChatFromJson(Map<String, dynamic> json) => FeedbackChat(
      messageContent: json['messageContent'] as String,
      messageType: json['messageType'] as int,
      idFrom: json['idFrom'] as String,
      idTo: json['idTo'] as String,
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$FeedbackChatToJson(FeedbackChat instance) =>
    <String, dynamic>{
      'messageContent': instance.messageContent,
      'messageType': instance.messageType,
      'idTo': instance.idTo,
      'idFrom': instance.idFrom,
      'timestamp': instance.timestamp,
    };
