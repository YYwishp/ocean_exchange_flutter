import 'package:json_annotation/json_annotation.dart'; 

part 'generate/login_response.g.dart';

@JsonSerializable(nullable: false,ignoreUnannotated: false)
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

@JsonSerializable(nullable: false,ignoreUnannotated: false)
class Data {

  Data();

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

