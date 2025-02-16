import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tanvir/auth_controller.dart';
import 'package:tanvir/services/debug_print.dart';
import 'package:tanvir/services/network_response.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint("GET Request: $url");

      // Adding the Authorization header in the format "Bearer <token>"
      Map<String, String> headers = {
        'Authorization': 'Bearer ${AuthController.accessToken}', // Use Bearer token format
        'Accept': 'application/json',
      };

      final response = await http.get(uri, headers: headers);
      debugPrint("Response: ${response.statusCode} - ${response.body}");

      final decodeData = jsonDecode(response.body);

      if (response.statusCode == 200 && decodeData['status'] == 'success') {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseBody: decodeData,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMassage: decodeData['data'] ?? 'Unknown error occurred',
        );
      }
    } catch (e) {
      return NetworkResponse(statusCode: -1, isSuccess: false, errorMassage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    required Map<String, dynamic> body,
    File? file,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      print("POST Request URL: $url");

      http.BaseRequest request;
      Map<String, String> headers = {
        'Authorization': 'Bearer ${AuthController.accessToken}',
        'Accept': 'application/json',
      };

      if (file != null) {
        // Multipart request for file upload
        var multipartRequest = http.MultipartRequest("POST", uri);

        // Add form fields
        body.forEach((key, value) {
          multipartRequest.fields[key] = value.toString();
        });

        // Attach file
        multipartRequest.files.add(
          await http.MultipartFile.fromPath('file', file.path),
        );

        request = multipartRequest;
      } else {
        // JSON request if no file is needed
        request = http.Request("POST", uri)
          ..headers.addAll(headers)
          ..body = jsonEncode(body);
      }

      // Send the request
      var streamedResponse = await http.Client().send(request);
      var response = await http.Response.fromStream(streamedResponse);

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final decodeData = jsonDecode(response.body);

      if (response.statusCode == 200 || decodeData['status'] == 'success') {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseBody: decodeData,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMassage: decodeData['message'] ?? "Request failed",
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMassage: e.toString(),
      );
    }
  }
}
