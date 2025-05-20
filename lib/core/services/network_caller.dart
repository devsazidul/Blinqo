import 'dart:convert';

import 'package:blinqo/core/common/models/network_response.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkCaller {
  final Logger _logger = Logger();

  //* ------------------------------------------------
  //* get request
  //* ------------------------------------------------
  Future<NetworkResponse> getRequest(String url, {String? accessToken}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {'content-type': 'application/json'};
      if (accessToken != null) {
        headers['Authorization'] = "Bearer $accessToken";
      } else {
        headers['Authorization'] = "Bearer ${SpAuthController.token}";
      }
      // if (accessToken != null || SpAuthController.token != null) {
      //   headers['Authorization'] =
      //       "Bearer ${accessToken ?? SpAuthController.token}";
      // } else {
      //   headers['Authorization'] = "Bearer $accessToken";
      // }
      _logRequest(url, headers);
      final response = await http.get(uri, headers: headers);
      _logResponse(url, response.statusCode, response.headers, response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, "", e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  //* ------------------------------------------------
  //* post request
  //* ------------------------------------------------
  Future<NetworkResponse> postRequest(
    String url,
    Map<String, dynamic>? body,
  ) async {
    try {
      Uri uri = Uri.parse(url);
      final headers = {"Content-Type": "application/json"};
      if (SpAuthController.token != null) {
        headers['Authorization'] = "Bearer ${SpAuthController.token}";
      }

      _logRequest(url, headers, body);
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _logResponse(url, response.statusCode, response.headers, response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: jsonDecode(response.body)["message"] ?? "",
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, "", e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  //* ------------------------------------------------
  //* Multipart Request
  //* ------------------------------------------------
  Future<NetworkResponse> multipartRequest({
    required String url,
    Map<String, String>? formFields,
    List<http.MultipartFile>? files,
    bool? isPatchRequest = false,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      final headers = {"Content-Type": "multipart/form-data"};
      _logger.i('Current token value: ${SpAuthController.token}');
      if (SpAuthController.token != null) {
        headers['Authorization'] = "Bearer ${SpAuthController.token}";
        _logger.i('Added Authorization header: ${headers['Authorization']}');
      } else {
        _logger.w('No token available for request');
      }
      final request =
          isPatchRequest == true
              ? http.MultipartRequest('PATCH', uri)
              : http.MultipartRequest('POST', uri);
      request.headers.addAll(headers);
      if (formFields != null) {
        request.fields.addAll(formFields);
        _logger.i('Form Fields => $formFields');
      }
      if (files != null) {
        for (var file in files) {
          request.files.add(file);
          _logger.i('File => $file');
        }
      }
      _logger.i('Request => $request');
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200 || response.statusCode == 201) {
        _logger.i('Url => $url\nResponse => $responseBody');
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(responseBody),
        );
      } else {
        _logger.e('Url => $url\nResponse => $responseBody');
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: responseBody,
        );
      }
    } catch (e) {
      _logger.e('Url => $url\nError => $e');
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  //* ------------------------------------------------
  //* patch request
  //* ------------------------------------------------
  Future<NetworkResponse> patchRequest(
    String url,
    Map<String, dynamic>? body,
  ) async {
    try {
      Uri uri = Uri.parse(url);
      final headers = {"Content-Type": "application/json"};
      if (SpAuthController.token != null) {
        headers['Authorization'] = "Bearer ${SpAuthController.token}";
      }
      _logRequest(url, headers, body);
      http.Response response = await http.patch(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _logResponse(url, response.statusCode, response.headers, response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, "", e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  //* ------------------------------------------------
  //* delete request
  //* ------------------------------------------------
  Future<NetworkResponse> deleteRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      final headers = {"Content-Type": "application/json"};
      if (SpAuthController.token != null) {
        headers['Authorization'] = "Bearer ${SpAuthController.token}";
      }
      _logRequest(url, headers);
      http.Response response = await http.delete(uri, headers: headers);
      _logResponse(url, response.statusCode, response.headers, response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, "", e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  void _logRequest(
    String url, [
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  ]) {
    _logger.i(
      "Request URL => $url\nRequest Header => $headers\nRequest Body => $body",
    );
  }

  void _logResponse(
    String url,
    int statusCode,
    Map<String, dynamic>? headers,
    String body, [
    String? errorMessage,
  ]) {
    if (errorMessage != null) {
      _logger.e(
        "Url => $url\nResponse Status Code => $statusCode\nResponse Error Message => $errorMessage",
      );
    } else {
      _logger.i(
        "Url => $url\nResponse Status Code => $statusCode\nResponse Headers => $headers\nResponse Body => $body",
      );
    }
  }
}
