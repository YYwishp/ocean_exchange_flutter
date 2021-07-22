import 'package:json_annotation/json_annotation.dart'; 

part 'generate/legal_tenders_entity.g.dart';
///
/// {
//   "code": 0,
//   "message": "",
//   "data": [
//     {
//       "code": "AED",
//       "rate": "3.6700000000"
//     },
//     {
//       "code": "BDT",
//       "rate": "84.8800000000"
//     },
//     {
//       "code": "CAD",
//       "rate": "1.2700000000"
//     },
//     {
//       "code": "CNY",
//       "rate": "6.4900000000"
//     },
//     {
//       "code": "EUR",
//       "rate": "0.8460000000"
//     },
//     {
//       "code": "GBP",
//       "rate": "0.7290000000"
//     },
//     {
//       "code": "HKD",
//       "rate": "7.7700000000"
//     },
//     {
//       "code": "KRW",
//       "rate": "1151.1100000000"
//     },
//     {
//       "code": "PHP",
//       "rate": "50.8000000000"
//     },
//     {
//       "code": "RUB",
//       "rate": "74.5600000000"
//     },
//     {
//       "code": "SGD",
//       "rate": "1.3600000000"
//     },
//     {
//       "code": "TRY",
//       "rate": "8.5800000000"
//     },
//     {
//       "code": "USD",
//       "rate": "1.0000000000"
//     },
//     {
//       "code": "VND",
//       "rate": "23050.4300000000"
//     },
//     {
//       "code": "ZWL",
//       "rate": "322.0001349949"
//     }
//   ]
// }
///
///
///







@JsonSerializable(ignoreUnannotated: false)
class LegalTendersEntity {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  List<Data>? data;

  LegalTendersEntity({this.code, this.message, this.data});

  factory LegalTendersEntity.fromJson(Map<String, dynamic> json) => _$LegalTendersEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LegalTendersEntityToJson(this);
}

@JsonSerializable(ignoreUnannotated: false)
class Data {
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'rate')
  String? rate;

  Data({this.code, this.rate});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

