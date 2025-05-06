import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class OwnerNetworkCaller {
  // Singleton instance for reusability
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

  // Headers (customize as needed, e.g., add token, dynamic content type)
  Map<String, String> _getHeaders({String? token, bool isMultipart = false}) {
    return {
      'Content-Type': isMultipart
          ? 'multipart/form-data'
          : 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // POST API call (handles both standard POST and multipart)
  Future<NetworkResponse> postRequest({
    required String Url,
    required Map<String, dynamic> body,
    String? token,
    bool showLoading = true,
    bool isMultipart = false, // Flag to switch to multipart
    List<http.MultipartFile>? files, // Files to upload (for multipart)
  }) async {
    try {
      // Show loading indicator
      if (showLoading) {
        await EasyLoading.show(status: 'Loading...');
      }

      final url = Uri.parse(Url);
      _logger.i('Request URL: $url\nBody: ${jsonEncode(body)}');

      if (isMultipart) {
        // Handle multipart request
        return await _sendMultipartRequest(url, body, files, token);
      } else {
        // Handle normal JSON POST request
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
      // Dismiss loading indicator
      if (showLoading) {
        await EasyLoading.dismiss();
      }
    }
  }

  // Handle multipart POST request
  Future<NetworkResponse> _sendMultipartRequest(
      Uri url,
      Map<String, dynamic> body,
      List<http.MultipartFile>? files,
      String? token,
      ) async {
    try {
      var request = http.MultipartRequest('POST', url)
        ..headers.addAll(_getHeaders(token: token, isMultipart: true));

      // Add fields to multipart request
      body.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Add files to the multipart request
      if (files != null) {
        for (var file in files) {
          request.files.add(file);
        }
      }

      // Send the request
      var response = await request.send().timeout(const Duration(seconds: 10));
      var responseData = await http.Response.fromStream(response);

      _logger.d('Multipart Response: ${response.statusCode}\nBody: ${responseData.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: jsonDecode(responseData.body),
        );
      } else {
        _logger.w('Multipart request failed: ${response.statusCode}\nMessage: ${responseData.body}');
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

  // Handle JSON POST request
  Future<NetworkResponse> _sendJsonRequest(
      Uri url,
      Map<String, dynamic> body,
      String? token,
      ) async {
    try {
      final response = await http.post(
        url,
        headers: _getHeaders(token: token),
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 10));

      _logger.d('Response: ${response.statusCode}\nBody: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: jsonDecode(response.body),
        );
      } else {
        _logger.w('Request failed: ${response.statusCode}\nMessage: ${response.body}');
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

// Response model to standardize API responses
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
