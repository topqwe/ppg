import '../../generated/json/base/json_convert_content.dart';
import '../../models/api_response/api_response_entity.dart';

ApiResponse<T> $ApiResponseFromJson<T>(Map<String, dynamic> json) {
  final ApiResponse<T> apiResponseEntity = ApiResponse<T>();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    apiResponseEntity.code = code;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    apiResponseEntity.msg = msg;
  }
  String type = T.toString();
  T? data;
  print("type:$type");
  if (json['data'] != null) {
    // if (type.startsWith("PagingData<")) {
    //   data = pagingDataFromJsonSingle<T>(json['data']);
    // } else {
      data = jsonConvert.convert<T>(json['data']);
    // }
  }
  if (data != null) {
    apiResponseEntity.data = data;
  }
  return apiResponseEntity;
}

Map<String, dynamic> $ApiResponseToJson(ApiResponse entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['msg'] = entity.msg;
  data['data'] = entity.data;
  return data;
}
