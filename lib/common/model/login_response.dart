import 'package:json_annotation/json_annotation.dart'; 

part 'generate/login_response.g.dart';

@JsonSerializable(ignoreUnannotated: false)
class LoginResponse {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  Data? data;

  LoginResponse({this.code, this.message, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable(ignoreUnannotated: false)
class Data {
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'i18n')
  String? i18n;
  @JsonKey(name: 'lock_remaining_count')
  int? lockRemainingCount;

  Data({this.token, this.i18n, this.lockRemainingCount});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

