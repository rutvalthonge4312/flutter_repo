import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sanchalak/constants/index.dart';
import 'package:sanchalak/services/api_services/index.dart';


class ApiService {
  static Future<dynamic> get(String endpoint, dynamic body) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    if (body != null && body.containsKey('token') && body['token'] != null) {
      headers['Authorization'] = 'Bearer ${body['token']}';
    }
    final response = await http.get(
      Uri.parse('${ApiConstant.baseUrl}$endpoint'),
      headers: headers,
    );
    return _handleResponse(response);
  }

  static Future<dynamic> post(String endpoint, dynamic body) async {
    body['token'] = body['token'] ?? body.remove('token');
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    if (body['token'] != null && body['token'].isNotEmpty) {
      headers['Authorization'] = 'Bearer ${body['token']}';
    }
    final response = await http.post(
      Uri.parse('${ApiConstant.baseUrl}$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    );
    print(response);
    return _handleResponse(response);
  }

  static Future<dynamic> put(String endpoint, dynamic body) async {
    final response = await http.put(
      Uri.parse('${ApiConstant.baseUrl}$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${body['token']}',
      },
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  static Future<dynamic> delete(String endpoint, dynamic body) async {
    final response = await http.delete(
      Uri.parse('${ApiConstant.baseUrl}$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${body['token']}',
      },
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  static dynamic _handleResponse(http.Response response) {
    final jsonResponse = json.decode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonResponse;
    } else {
      throw ApiException.fromJson(response.statusCode, jsonResponse);
    }

  }
}
