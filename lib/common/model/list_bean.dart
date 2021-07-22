import 'package:json_annotation/json_annotation.dart'; 

part 'generate/list_bean.g.dart';



///测试用
//{
//   "data": [
//     {
//       "type": 1,
//       "total": 0,
//       "detail": "今天有0位客人哟..."
//     },
//     {
//       "type": 2,
//       "total": 0,
//       "detail": "今天有0位客人..."
//     }
//   ],
//   "error": {
//     "message": "执行成功",
//     "code": 1
//   }
// }
@JsonSerializable(nullable: false,ignoreUnannotated: false)
class ListBean {
  @JsonKey(name: 'data')
  List<Data_> data;
  @JsonKey(name: 'error')
  Error error;

  ListBean({required this.data, required this.error});

  factory ListBean.fromJson(Map<String, dynamic> json) => _$ListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ListBeanToJson(this);
}

@JsonSerializable(nullable: false,ignoreUnannotated: false)
class Data_ {
  @JsonKey(name: 'type')
  int type;
  @JsonKey(name: 'total')
  int total;
  @JsonKey(name: 'detail')
  String detail;

  Data_({required this.type, required this.total, required this.detail});

  factory Data_.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable(nullable: false,ignoreUnannotated: false)
class Error {
  @JsonKey(name: 'message')
  String message;
  @JsonKey(name: 'code')
  int code;

  Error({required this.message, required this.code});

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}

