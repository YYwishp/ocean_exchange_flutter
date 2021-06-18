// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListBean _$ListBeanFromJson(Map<String, dynamic> json) {
  return ListBean(
    data: (json['data'] as List<dynamic>)
        .map((e) => Data_.fromJson(e as Map<String, dynamic>))
        .toList(),
    error: Error.fromJson(json['error'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ListBeanToJson(ListBean instance) => <String, dynamic>{
      'data': instance.data,
      'error': instance.error,
    };

Data_ _$DataFromJson(Map<String, dynamic> json) {
  return Data_(
    type: json['type'] as int,
    total: json['total'] as int,
    detail: json['detail'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data_ instance) => <String, dynamic>{
      'type': instance.type,
      'total': instance.total,
      'detail': instance.detail,
    };

Error _$ErrorFromJson(Map<String, dynamic> json) {
  return Error(
    message: json['message'] as String,
    code: json['code'] as int,
  );
}

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
    };
