import '../../../api/request/config.dart';
import '../../../api/request/exception.dart';
import '../../../api/request/exception_handler.dart';
import '../../../util/loading.dart';
Future request(Function() block,
    {bool showLoading = false,
    bool Function(ApiException)? onError,
    Function? otherFun = null}) async {
  print(
      '---------------------------------------------------------------------------------------');
  print(block);
  try {
    if (otherFun != null) {
      otherFun();
    }
    await loading(block, isShowLoading: showLoading);
  } catch (e) {
    handleException(ApiException.from(e), onError: onError);
  }
  return;
}
