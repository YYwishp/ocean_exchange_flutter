import 'package:json_annotation/json_annotation.dart'; 

part 'generate/verifycode_response.g.dart';

@JsonSerializable(nullable: true)
class VerifycodeResponse {
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  VerifycodeResponse({this.code, this.message, this.data});

  factory VerifycodeResponse.fromJson(Map<String, dynamic> json) => _$VerifycodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifycodeResponseToJson(this);
}

@JsonSerializable(nullable: true)
class Data {

  Data();

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

