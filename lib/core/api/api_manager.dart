import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../utils/app_strings.dart';
import 'endpoints.dart';
import 'methods.dart';
import '../../injection_container.dart' as di;

class ApiManager {
  static final instance = ApiManager();
  Dio dio = Dio(BaseOptions(baseUrl: EndPoints.baseUrl));
  Response<dynamic>? res;

  ApiManager() {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 120,
      ),
    );
  }

  Future<Response<dynamic>> fetch({
    required bool interceptorsWrapper,
    required Methods method,
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    Object? body,
  }) async {
    var storage = di.sl<FlutterSecureStorage>();
    var lang = await storage.read(key: AppStrings.appLang);
    final options = Options(
      headers: {AppStrings.acceptLanguage: lang, ...?headers},
      validateStatus: (statusCode) {
        if (statusCode! >= 400 && statusCode < 500 ||
            statusCode >= 200 && statusCode < 300) {
          return true;
        } else {
          return false;
        }
      },
      contentType: AppStrings.applicationJson,
    );

    try {
      switch (method) {
        case Methods.get:
          res = await dio.get(
            endpoint,
            data: body,
            queryParameters: queryParams,
            options: options,
          );
          break;
        case Methods.post:
          res = await dio.post(
            endpoint,
            data: body,
            queryParameters: queryParams,
            options: options,
          );
          break;
        case Methods.patch:
          res = await dio.patch(
            endpoint,
            data: body,
            queryParameters: queryParams,
            options: options,
          );
          break;
        case Methods.delete:
          res = await dio.delete(
            endpoint,
            data: body,
            queryParameters: queryParams,
            options: options,
          );
          break;
        case Methods.put:
          res = await dio.put(
            endpoint,
            data: body,
            queryParameters: queryParams,
            options: options,
          );
          break;
      }
      return res!;
    } on DioException {
      rethrow;
    }
  }
}
