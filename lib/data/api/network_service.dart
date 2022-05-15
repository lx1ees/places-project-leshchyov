import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:places/constants/app_constants.dart';

/// Класс сервиса с сетевым клиентом
class NetworkService {
  late final Dio client;

  NetworkService() {
    client = _initDio();
  }

  Dio _initDio() {
    final options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.connectTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      sendTimeout: AppConstants.sendTimeout,
      validateStatus: (status) {
        /// Считаем запросы успешными только с этими кодами, остальные
        /// попадают в onError
        return status == 200 || status == 201;
      },
    );

    return Dio(options)
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            debugPrint(options.path);

            return handler.next(options);
          },
          onResponse: (response, handler) {
            return handler.next(response);
          },
          onError: (error, handler) {
            return handler.next(error);
          },
        ),
      );
  }
}
