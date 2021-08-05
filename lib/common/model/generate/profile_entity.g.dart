// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../profile_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileEntity _$ProfileEntityFromJson(Map<String, dynamic> json) {
  return ProfileEntity(
    sn: json['sn'] as String?,
    email: json['email'] as String?,
  );
}

Map<String, dynamic> _$ProfileEntityToJson(ProfileEntity instance) =>
    <String, dynamic>{
      'sn': instance.sn,
      'email': instance.email,
    };
