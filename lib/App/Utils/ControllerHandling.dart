import 'package:get/get.dart';

Future<void> controllerHandling(
    Future<void> Function() action,
    RxMap<String, bool> loadingStates,
    String actionKey,
    RxMap<String, String?> errorMessages,
    String errorKey, {
      Function()? onError,
      Function()? onEnd,
    }) async {
  loadingStates[actionKey] = true;
  try {
    errorMessages[errorKey] = null;
    await action();
  } catch (e) {
    onError?.call();
    errorMessages[errorKey] = e.toString();
    Get.snackbar('Error', e.toString());
  } finally {
    loadingStates[actionKey] = false;
    onEnd?.call();
  }
}