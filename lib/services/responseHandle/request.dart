
import '../../../util/loading.dart';
import 'exception.dart';
import 'exception_handler.dart';
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
