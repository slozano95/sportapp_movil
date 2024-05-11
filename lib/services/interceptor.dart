import 'dart:convert';

import 'dart:typed_data';

import 'package:http/http.dart' as http;

class MyInterceptor extends http.BaseClient {
  final http.Client _inner;

  MyInterceptor(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    print('Request: ${request.method} ${request.url}');
    if (request.headers.isNotEmpty) {
      print('Headers:');
      request.headers.forEach((name, value) {
        print('$name: $value');
      });
    }
    if (request is http.Request) {
      print('Body:');
      print(request.body);
    }

    final response = await _inner.send(request);

    print('Response: ${response.statusCode}');
    if (response.headers.isNotEmpty) {
      print('Headers:');
      response.headers.forEach((name, value) {
        print('$name: $value');
      });
    }
    return response;
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) {
    return _inner.head(url, headers: headers);
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    return _inner.get(url, headers: headers);
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return _inner.post(url, headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return _inner.put(url, headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<http.Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return _inner.patch(url, headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) {
    return _inner.read(url, headers: headers);
  }

  @override
  void close() {
    _inner.close();
  }
}
