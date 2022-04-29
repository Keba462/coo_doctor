import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'covid_user.g.dart';

@JsonSerializable()
class CovidUser {
  String userId;
  String omang;
  String fullName;
  String email;
  String role;

  CovidUser({
    required this.userId,
    required this.omang,
    required this.fullName,
    required this.email,
    required this.role
    });
     factory CovidUser.fromDocument(DocumentSnapshot snapshot) {

    String userId = "";
    String fullName = "";
    String aboutMe = "";

    try {
      fullName = snapshot.get("fullName");
      userId = snapshot.get("userId");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return CovidUser(omang:"12418975",fullName: fullName, email: "email",role: "patient", userId: userId);
  }
  

  factory CovidUser.fromJson(Map<String, dynamic> json) => _$CovidUserFromJson(json);
  Map<String, dynamic> toJson() => _$CovidUserToJson(this);
}
