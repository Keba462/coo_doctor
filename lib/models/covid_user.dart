import 'package:json_annotation/json_annotation.dart';
part 'covid_user.g.dart';

@JsonSerializable()
class CovidUser {
  String omang;
  String fullName;
  String email;
  String role;

  CovidUser({
    required this.omang,
    required this.fullName,
    required this.email,
    required this.role
  });

  factory CovidUser.fromJson(Map<String, dynamic> json) => _$CovidUserFromJson(json);
  Map<String, dynamic> toJson() => _$CovidUserToJson(this);
}
