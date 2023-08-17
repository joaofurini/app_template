import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../http/interceptors/custom_interceptor.dart';

class CustomDio extends DioForNative {
  CustomDio([BaseOptions? options]) : super(options) {
    (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    interceptors.add(CustomInterceptors());
  }
}
