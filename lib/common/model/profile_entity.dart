import 'package:json_annotation/json_annotation.dart'; 

part 'generate/profile_entity.g.dart';

@JsonSerializable(ignoreUnannotated: false)
class ProfileEntity {
  @JsonKey(name: 'sn')
  String? sn;
  @JsonKey(name: 'email')
  String? email;

  ProfileEntity({this.sn, this.email});

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => _$ProfileEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileEntityToJson(this);
}

