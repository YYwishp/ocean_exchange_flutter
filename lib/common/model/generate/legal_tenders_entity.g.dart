// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../legal_tenders_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LegalTendersEntity _$LegalTendersEntityFromJson(Map<String, dynamic> json) {
  return LegalTendersEntity(
    code: json['code'] as int?,
    message: json['message'] as String?,
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => Data.fromJson(Map<String, String>.from(e as Map)))
        .toList(),
  );
}

Map<String, dynamic> _$LegalTendersEntityToJson(LegalTendersEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    code: json['code'] as String?,
    rate: json['rate'] as String?,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'code': instance.code,
      'rate': instance.rate,
    };
