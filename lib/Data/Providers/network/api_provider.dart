import 'dart:async';
import 'package:get/get_connect/connect.dart';
import 'api_request_representable.dart';

class APIProvider {
  static const requestTimeOut = Duration(seconds: 25);
  final _client = GetConnect(timeout: requestTimeOut);

  static final _singleton = APIProvider();
  static APIProvider get instance => _singleton;

  Future request(APIRequestRepresentable request) async {
    final response = await _client.request(
      request.url,
      request.method.string,
      headers: request.headers,
      query: request.query,
      body: request.body,
    );
    return _returnResponse(response);
  }

  dynamic _returnResponse(Response<dynamic> response) {
    if (response.statusCode == 200) {
      return response.body;
    }
    if (response.statusCode == 201) {
      return response.body;
    }
    if (response.statusCode == 204) {
      return;
    }
    final errorDetails = response.body['error'].toString();
    final errorMessage = response.body['message'].toString();
    final errorCode = "HTTP ${response.statusCode}";

    switch (response.statusCode) {
      case 400:
        throw BadRequestException(
          code: errorCode,
          message: errorMessage,
          details: errorDetails,
        );
      case 401:
        throw UnauthorisedException(
          code: errorCode,
          message: errorMessage,
          details: errorDetails,
        );
      case 403:
        throw ForbiddenException(
          code: errorCode,
          message: errorMessage,
          details: errorDetails,
        );
      case 404:
        throw NotFoundException(
          code: errorCode,
          message: errorMessage,
          details: errorDetails,
        );
      case 405:
        throw MethodNotAllowedException(
          code: errorCode,
          message: errorMessage,
          details: errorDetails,
        );
      case 422:
        throw UnprocessableEntityException(
          code: errorCode,
          message: errorMessage,
          details: errorDetails,
        );
      case 429:
        throw TooManyRequestsException(
          code: errorCode,
          message: errorMessage,
          details: errorDetails,
        );
      case 500:
        throw FetchDataException(
          'Internal Server Error: $errorMessage',
        );
      case 502:
        throw BadGatewayException(
          code: errorCode,
          message: errorMessage,
          details: errorDetails,
        );
      case 503:
        throw ServiceUnavailableException(
          code: errorCode,
          message: errorMessage,
          details: errorDetails,
        );
      case 504:
        throw GatewayTimeoutException(
          code: errorCode,
          message: errorMessage,
          details: errorDetails,
        );
      default:
        throw FetchDataException(
          'Unexpected error with status code: ${response.statusCode}',
        );
    }
  }
}

class AppException implements Exception {
  final String code;
  final String message;
  final String? details;

  AppException({
    required this.code,
    required this.message,
    this.details,
  });

  @override
  String toString() {
    return "$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException(String details)
      : super(
    code: "fetch-data",
    message: "Error During Communication",
    details: details,
  );
}

class BadRequestException extends AppException {
  BadRequestException({required String code, required String message, String? details})
      : super(
    code: code,
    message: message,
    details: details,
  );
}

class UnauthorisedException extends AppException {
  UnauthorisedException({required String code, required String message, String? details})
      : super(
    code: code,
    message: message,
    details: details,
  );
}

class ForbiddenException extends AppException {
  ForbiddenException({required String code, required String message, String? details})
      : super(
    code: code,
    message: message,
    details: details,
  );
}

class NotFoundException extends AppException {
  NotFoundException({required String code, required String message, String? details})
      : super(
    code: code,
    message: message,
    details: details,
  );
}

class MethodNotAllowedException extends AppException {
  MethodNotAllowedException({required String code, required String message, String? details})
      : super(
    code: code,
    message: message,
    details: details,
  );
}

class UnprocessableEntityException extends AppException {
  UnprocessableEntityException({required String code, required String message, String? details})
      : super(
    code: code,
    message: message,
    details: details,
  );
}

class TooManyRequestsException extends AppException {
  TooManyRequestsException({required String code, required String message, String? details})
      : super(
    code: code,
    message: message,
    details: details,
  );
}

class BadGatewayException extends AppException {
  BadGatewayException({required String code, required String message, String? details})
      : super(
    code: code,
    message: message,
    details: details,
  );
}

class ServiceUnavailableException extends AppException {
  ServiceUnavailableException({required String code, required String message, String? details})
      : super(
    code: code,
    message: message,
    details: details,
  );
}

class GatewayTimeoutException extends AppException {
  GatewayTimeoutException({required String code, required String message, String? details})
      : super(
    code: code,
    message: message,
    details: details,
  );
}

class TimeOutException extends AppException {
  TimeOutException(String details)
      : super(
    code: "request-timeout",
    message: "Request Timeout",
    details: details,
  );
}
