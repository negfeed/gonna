// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      json['firstName'] as String,
      json['lastName'] as String,
      isPhoneDirectoryInitialized: json['isPhoneDirectoryInitialized'] as bool?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'isPhoneDirectoryInitialized': instance.isPhoneDirectoryInitialized,
    };
