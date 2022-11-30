import 'dart:convert';
import '../../models/api_response/api_response_entity.g.dart';

class ApiResponse<T> {
  int? code;
  String? msg;
  T? data;

  ApiResponse();

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      $ApiResponseFromJson<T>(json);

  Map<String, dynamic> toJson() => $ApiResponseToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
