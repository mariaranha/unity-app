import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  final Duration timeout;
  final http.Client client;

  ApiService({String? baseUrl, Duration? timeout, http.Client? client})
    : baseUrl = baseUrl ?? 'http://localhost:3000',
      timeout = timeout ?? const Duration(seconds: 10),
      client = client ?? http.Client();

  Uri _uri(String path) => Uri.parse(baseUrl + path);

  Future<dynamic> get(String path, {Map<String, String>? headers}) async {
    final uri = _uri(path);
    final resp = await client.get(uri, headers: headers).timeout(timeout);
    return _processResponse(resp);
  }

  Future<dynamic> post(
    String path, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final uri = _uri(path);
    final resp = await client
        .post(uri, headers: headers, body: body)
        .timeout(timeout);
    return _processResponse(resp);
  }

  Future<dynamic> put(
    String path, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final uri = _uri(path);
    final resp = await client
        .put(uri, headers: headers, body: body)
        .timeout(timeout);
    return _processResponse(resp);
  }

  Future<dynamic> delete(String path, {Map<String, String>? headers}) async {
    final uri = _uri(path);
    final resp = await client.delete(uri, headers: headers).timeout(timeout);
    return _processResponse(resp);
  }

  dynamic _processResponse(http.Response resp) {
    final code = resp.statusCode;
    if (code >= 200 && code < 300) {
      if (resp.body.isEmpty) return null;
      try {
        return json.decode(resp.body);
      } catch (_) {
        return resp.body;
      }
    }
    String message = resp.body;
    try {
      final decoded = json.decode(resp.body);
      if (decoded is Map && decoded['message'] != null) {
        message = decoded['message'].toString();
      }
    } catch (_) {}
    throw ApiException(code, message);
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;
  ApiException(this.statusCode, this.message);

  @override
  String toString() => 'ApiException($statusCode): $message';
}
