import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class LegendApiInterface {
  static Future<ApiReturn<T>> postCall<T>(Uri url) async {
    // check if Uri is valid
    if (!url.isAbsolute) {
      return ApiReturn(
        ApiStatus.Error,
        null,
      );
    }

    http.Response response = await http.post(url);

    switch (response.statusCode) {
      case 200:
        T json = convert.jsonDecode(response.body) as T;
        return ApiReturn<T>(
          ApiStatus.Success,
          json,
        );
      default:
        print(response.statusCode);
        return ApiReturn(
          ApiStatus.Error,
          null,
        );
    }
  }

  static Future<ApiReturn<T>> getCall<T>(Uri url) async {
    print(url);

    // check if Uri is valid
    if (!url.isAbsolute) {
      return ApiReturn(
        ApiStatus.Error,
        null,
      );
    }

    http.Response response = await http.get(url);

    switch (response.statusCode) {
      case 200:
        T json = convert.jsonDecode(response.body) as T;
        return ApiReturn<T>(
          ApiStatus.Success,
          json,
        );
      default:
        print(response.statusCode);
        return ApiReturn(
          ApiStatus.Error,
          null,
        );
    }
  }
}

class ApiReturn<T> {
  final ApiStatus status;
  final T? data;

  ApiReturn(this.status, this.data);
}

enum ApiStatus {
  Success,
  Loading,
  Error,
}
