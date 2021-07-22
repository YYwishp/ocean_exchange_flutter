// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../verifycode_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifycodeResponse _$VerifycodeResponseFromJson(Map<String, dynamic> json) {
  return VerifycodeResponse(
    code: json['code'] as int,
    message: json['message'] as String,
    data: Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VerifycodeResponseToJson(VerifycodeResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data();
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{};
