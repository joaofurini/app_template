import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CustomInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // final authRepository = Modular.get<IAuthRepository>();

    // options.connectTimeout = 10 * 1000;

    if (kDebugMode) {
      //debugPrint(json.encode('BaseURL: ${options.baseUrl}'));
      debugPrint(json.encode('Endpoint: ${options.path}'));

      // if (options.headers['Authorization'] != null) {
      //   debugPrint("Authorization: ${options.headers['Authorization']}");
      // }

      if (options.data != null) {
        debugPrint('Payload ${json.encode(options.data)}');
      }
    }

    return super.onRequest(options, handler);
  }

  // @override
  // Future onResponse(
  //     Response response, ResponseInterceptorHandler handler) async {
  //   return super.onResponse(response, handler);
  // }

  // @override
  // Future<dynamic> onError(DioError err, ErrorInterceptorHandler handler) async {
  //   print(err.message);

  //   if (err.response != null && err.response!.data != null) {
  //     if (err.response!.statusCode == 400) {
  //       handler.next(err);
  //       throw BusinessException.fromJson(json.decode(err.response!.data));
  //     }
  //   }

  //   return super.onError(err, handler);
  // }
  // @override
  // Future onError(DioError err) async {
  //   if (err.response.statusCode == 401) {
  //     var dio = Modular.get<DioForNative>();
  //     var userService = Modular.get<IUserService>();
  //     var user = await userService.getCurrentUser();
  //     if (user != null && err.response.statusCode == 401) {
  //       var options = err.response.request;

  //       if (user.token == options.headers['Authorization']) {
  //         options.headers['Authorization'] = user.token;
  //         return dio.request(options.path, options: options);
  //       }
  //       dio.lock();
  //       dio.interceptors.responseLock.lock();
  //       dio.interceptors.errorLock.lock();

  //       return userService
  //           .login(
  //               AuthenticateModel(login: user.login, password: user.password))
  //           .then((result) {
  //         result.fold(
  //           (_) {},
  //           (user) {
  //             var _newToken = user.token;

  //             if (_newToken != null && _newToken.isNotEmpty) {
  //               var headerAuth = genToken(_newToken);
  //               options.headers['Authorization'] = headerAuth;
  //             }
  //           },
  //         );
  //       }).whenComplete(() {
  //         dio.unlock();
  //         dio.interceptors.responseLock.unlock();
  //         dio.interceptors.errorLock.unlock();
  //       }).then((e) => dio.request(options.path, options: options));
  //     }
  //   } else {
  //     throw err;
  //   }
  // }

  String genToken(String token) {
    return 'Bearer $token';
  }
}
