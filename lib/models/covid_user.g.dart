// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidUser _$CovidUserFromJson(Map<String, dynamic> json) => CovidUser(
      omang: json['omang'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$CovidUserToJson(CovidUser instance) => <String, dynamic>{
      'omang': instance.omang,
      'fullName': instance.fullName,
      'email': instance.email,
      'role': instance.role,
    };
