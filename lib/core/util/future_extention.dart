import 'dart:async';

extension FutureExt<T> on Future<T> {
  /// Returns a Future that completes as void and don't care about the result.
  /// This is useful when you want to ignore the result/error of a Future.
  static Future<void> allSettled<T>(
    Iterable<Future<T>> futures, {
    void cleanUp(T successValue)?,
    void onError(Object error, StackTrace? stackTrace)?,
  }) async {
    int remaining = futures.length;
    final completor = Completer<void>();
    // Handle an error from any of the futures.
    void handleError(Object theError, StackTrace theStackTrace) {
      remaining--;
      onError?.call(theError, theStackTrace);
      if (remaining == 0) completor.complete();
    }

    try {
      for (var future in futures) {
        future.then((T value) {
          remaining--;
          cleanUp?.call(value);
          if (remaining == 0) completor.complete();
        }, onError: handleError);
      }
    } catch (e, st) {
      onError?.call(e, st);
    }
    return completor.future;
  }
}
