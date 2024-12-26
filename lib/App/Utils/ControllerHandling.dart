import 'package:get/get.dart';

Future<void> controllerHandling(
  Future<void> Function() action,
  RxMap<String, RxBool> loadingStates,
  String actionKey,
  RxMap<String, String?> errorMessages,
  String errorKey, {
  Function()? onError,
  Function()? onEnd,
  Map<String, int>? activeRequests,
  String? activeRequestsKey,
}) async {
  if (activeRequests != null && activeRequestsKey != null) {
    if (activeRequests[activeRequestsKey] == null) {
      activeRequests[activeRequestsKey] = 0;
    }
    activeRequests[activeRequestsKey] =
        (activeRequests[activeRequestsKey]! + 1);
  }

  loadingStates[actionKey] = true.obs;

  try {
    errorMessages[errorKey] = null;
    await action();
  } catch (e) {
    onError?.call();
    errorMessages[errorKey] = e.toString();
    Get.snackbar('Error', e.toString());
  } finally {
    if (activeRequests != null && activeRequestsKey != null) {
      if (activeRequests[activeRequestsKey]! > 0) {
        activeRequests[activeRequestsKey] =
            (activeRequests[activeRequestsKey]! - 1);
      }
      if (activeRequests[activeRequestsKey] == 0) {
        loadingStates[actionKey] = false.obs;
      }
    } else {
      loadingStates[actionKey] = false.obs;
    }
    onEnd?.call();
  }
}