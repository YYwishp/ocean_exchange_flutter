// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
    code: json['code'] as int,
    message: json['message'] as String,
    data: Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data();
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{};
