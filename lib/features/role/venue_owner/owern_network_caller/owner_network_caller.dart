import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';


class OwnerNetworkCaller {
  // Singleton instance for reusability
  static final OwnerNetworkCaller _instance = OwnerNetworkCaller._internal();
  factory OwnerNetworkCaller() => _instance;
  OwnerNetworkCaller._internal();

  // Logger instance for debugging
  final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  // Headers (customize as needed, e.g., add token)
  Map<String, String> _getHeaders({String? token}) {
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // POST API call
  Future<NetworkResponse> postRequest({
    required String Url,
    required Map<String, dynamic> body,
    String? token,
    bool showLoading = true,
  }) async {
    try {
      // Show loading indicator
      if (showLoading) {
        await EasyLoading.show(status: 'Loading...');
      }

      // Construct full URL
      final url = Uri.parse(Url);
      _logger.i('POST Request: $url\nBody: ${jsonEncode(body)}');

      // Make POST request
      final response = await http.post(
        url,
        headers: _getHeaders(token: token),
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 10));

      // Log response
      _logger.d('Response: ${response.statusCode}\nBody: ${response.body}');

      // Parse response
      final responseData = jsonDecode(response.body);

      // Handle response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: responseData,
        );
      } else {
        _logger.w('Request failed: ${response.statusCode}\nMessage: ${responseData['message']}');
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: responseData['message'] ?? 'Request failed',
        );
      }
    } catch (e) {
      _logger.e('Error: $e');
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    } finally {
      // Dismiss loading indicator
      if (showLoading) {
        await EasyLoading.dismiss();
      }
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