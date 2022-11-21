part of 'base_source.dart';

abstract class Source extends BaseSource {
  Source({required String methodName})
      : super(
            apiUrl: Config().API_URL, methodName: methodName, parser: Parser());

  Future<ApiResponse<T>?> get<T>(
    String url, {
    Map<String, dynamic> dioExtraOptions = const {},
    bool snackbarOnError = true,
    bool throwOnError = false,
    bool retry = true,
  }) async {
    final res = await _get(
      url,
      dioExtraOptions: dioExtraOptions,
      snackbarOnError: snackbarOnError,
      throwOnError: throwOnError,
      retry: retry,
    );


    return parser.parse<T>(res);
  }

  Future<List<T>?> getList<T>(
    String url, {
    Map<String, dynamic> dioExtraOptions = const {},
    bool snackbarOnError = true,
    bool throwOnError = false,
    bool retry = true,
  }) async {
    final res = await _get(
      url,
      dioExtraOptions: dioExtraOptions,
      snackbarOnError: snackbarOnError,
      throwOnError: throwOnError,
      retry: retry,
    );
    final list = res?.data['response'] as List?;
    if (list == null) return null;
    final List<T> result = [];
    list.forEach((element) {
      final data = parser.parseMap<T>(element)?.data;
      result.add(data!);
    });
    return result;
  }

  Future<ApiResponse<T>?> post<T>(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic> dioExtraOptions = const {},
    bool snackbarOnError = true,
    bool throwOnError = false,
    bool retry = true,
  }) async {
    print("body ${body.toString()}");

    final res = await _post(
      url,
      body: body,
      dioExtraOptions: dioExtraOptions,
      snackbarOnError: snackbarOnError,
      throwOnError: throwOnError,
      retry: retry,
    );
    return parser.parse<T>(res);
  }

  Future<ApiResponse<T>?> put<T>(
    String url, {
    required Map<String, dynamic> body,
    Map<String, dynamic> dioExtraOptions = const {},
    bool snackbarOnError = true,
    bool throwOnError = false,
    bool retry = true,
  }) async {
    final res = await _put(
      url,
      body: body,
      dioExtraOptions: dioExtraOptions,
      snackbarOnError: snackbarOnError,
      throwOnError: throwOnError,
      retry: retry,
    );
    print("PUT REQUEST ${res!.data.toString()}");
    return parser.parse<T>(res);
  }

  Future<bool> delete(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic> dioExtraOptions = const {},
    bool snackbarOnError = false,
    bool throwOnError = true,
    bool retry = false,
  }) async {
    try {
      var res = await dio.delete(
        url,
        options: Options(
          extra: {
            ReliableDioOption.SnackbarOnError.value: snackbarOnError,
            if (!retry) ...RetryOptions.noRetry().toExtra(),
            ...dioExtraOptions,
          },
        ),
      );
      print("res ${res.statusCode}");
      return res.statusCode == 200 ? true : false;
    } catch (e) {
      if (throwOnError) rethrow;
    }
    return false;
  }

  // Not a good way to do but couldn't find the other way around.
  Future<ApiResponse<T>?> deleteReturnData<T>(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic> query = const {},
    Map<String, dynamic> dioExtraOptions = const {},
    List<Function(T)>? listeners,
    bool snackbarOnError = false,
    bool throwOnError = true,
    bool retry = false,
  }) async {
    final res = await _delete(
      url,
      dioExtraOptions: dioExtraOptions,
      snackbarOnError: snackbarOnError,
      throwOnError: throwOnError,
      retry: retry,
    );
    final model = parser.parse<T>(res);
    if (model?.data != null && listeners != null && listeners.length > 0)
      listeners.forEach((event) => event(model!.data!));
    return model;
  }
}
