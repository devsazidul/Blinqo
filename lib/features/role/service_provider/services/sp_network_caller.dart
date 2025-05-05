import 'dart:convert';

import 'package:blinqo/features/role/service_provider/auth/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_response.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class SpNetworkCaller {
  final Logger _logger = Logger();
  Future<SpNetworkResponse> getRequest(
    String url, {
    String? accessToken,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {'content-type': 'application/json'};
      if (accessToken != null || SpAuthController.token != null) {
        headers['Authorization'] =
            "Bearer ${accessToken ?? SpAuthController.token}";
      }
      _logRequest(url, headers);
      final response = await http.get(uri, headers: headers);
      _logResponse(url, response.statusCode, response.headers, response.body);
      if (response.statusCode == 200) {
        return SpNetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        return SpNetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, "", e.toString());
      return SpNetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  // post request
  Future<SpNetworkResponse> postRequest(
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
        return SpNetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        return SpNetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: jsonDecode(response.body)["message"] ?? "",
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, "", e.toString());
      return SpNetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  // patch request
  Future<SpNetworkResponse> patchRequest(
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
        return SpNetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        return SpNetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, "", e.toString());
      return SpNetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  // delete request
  Future<SpNetworkResponse> deleteRequest(String url) async {
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
        return SpNetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        return SpNetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, "", e.toString());
      return SpNetworkResponse(
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
