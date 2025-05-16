import 'dart:convert';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class OwnerNetworkCaller {
  static final OwnerNetworkCaller _instance = OwnerNetworkCaller._internal();

  factory OwnerNetworkCaller() => _instance;

  OwnerNetworkCaller._internal();

  final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );

  Map<String, String> _getHeaders({String? token, bool isMultipart = false}) {
    return {
      'Content-Type': isMultipart ? 'multipart/form-data' : 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<NetworkResponse> postRequest({
    // ignore: non_constant_identifier_names
    required String Url,
    required Map<String, dynamic> body,
    String? token,
    bool showLoading = true,
    bool isMultipart = false,
    List<http.MultipartFile>? files,
    bool isPatch = false,
  }) async {
    try {
      if (showLoading) {
        await EasyLoading.show(status: 'Loading...');
      }

      // Fetch token if not provided
      token ??= await EventAuthController.getAuthToken();
      _logger.i(
        'Using token: ${token?.substring(0, 5)}...',
      ); // Log first 5 chars for security

      final url = Uri.parse(Url);
      _logger.i('Request URL: $url\nBody: ${jsonEncode(body)}');

      if (isMultipart) {
        return await _sendMultipartRequest(url, body, files, token, isPatch);
      } else {
        return await _sendJsonRequest(url, body, token);
      }
    } catch (e) {
      _logger.e('Error: $e');
      return NetworkResponse(
        isSuccess: false,
        statusCode: 500,
        errorMessage: e.toString(),
      );
    } finally {
      if (showLoading) {
        await EasyLoading.dismiss();
      }
    }
  }

  Future<NetworkResponse> getRequest({
    // ignore: non_constant_identifier_names
    required String Url,
    String? token,
    bool showLoading = true,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (showLoading) {
        await EasyLoading.show(status: 'Loading...');
      }

      // Fetch token if not provided
      token ??= await EventAuthController.getAuthToken();
      _logger.i('Using token: $token');

      final url = Uri.parse(Url).replace(queryParameters: queryParameters);
      _logger.i('GET Request URL: $url');

      final response = await http
          .get(url, headers: _getHeaders(token: token))
          .timeout(const Duration(seconds: 10));

      _logger.d('GET Response: ${response.statusCode}\nBody: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: jsonDecode(response.body),
        );
      } else {
        _logger.w(
          'GET request failed: ${response.statusCode}\nMessage: ${response.body}',
        );
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: jsonDecode(response.body)['message'],
        );
      }
    } catch (e) {
      _logger.e('Error: $e');
      return NetworkResponse(
        isSuccess: false,
        statusCode: 500,
        errorMessage: e.toString(),
      );
    } finally {
      if (showLoading) {
        await EasyLoading.dismiss();
      }
    }
  }

  Future<NetworkResponse> _sendMultipartRequest(
    Uri url,
    Map<String, dynamic> body,
    List<http.MultipartFile>? files,
    String? token, [
    bool isPatch = false,
  ]) async {
    try {
      var request = http.MultipartRequest(isPatch ? 'PATCH' : 'POST', url)
        ..headers.addAll(_getHeaders(token: token, isMultipart: true));

      body.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      if (files != null) {
        for (var file in files) {
          request.files.add(file);
        }
      }

      var response = await request.send().timeout(const Duration(seconds: 10));
      var responseData = await http.Response.fromStream(response);

      _logger.d(
        'Multipart Response: ${response.statusCode}\nBody: ${responseData.body}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: jsonDecode(responseData.body),
        );
      } else {
        _logger.w(
          'Multipart request failed: ${response.statusCode}\nMessage: ${responseData.body}',
        );
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: jsonDecode(responseData.body)['message'],
        );
      }
    } catch (e) {
      _logger.e('Error: $e');
      return NetworkResponse(
        isSuccess: false,
        statusCode: 500,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> _sendJsonRequest(
    Uri url,
    Map<String, dynamic> body,
    String? token,
  ) async {
    try {
      final response = await http
          .post(url, headers: _getHeaders(token: token), body: jsonEncode(body))
          .timeout(const Duration(seconds: 10));

      _logger.d('Response: ${response.statusCode}\nBody: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: jsonDecode(response.body),
        );
      } else {
        _logger.w(
          'Request failed: ${response.statusCode}\nMessage: ${response.body}',
        );
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: jsonDecode(response.body)['message'],
        );
      }
    } catch (e) {
      _logger.e('Error: $e');
      return NetworkResponse(
        isSuccess: false,
        statusCode: 500,
        errorMessage: e.toString(),
      );
    }
  }
}

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final dynamic body;
  final String? errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.body,
    this.errorMessage,
  });
}
