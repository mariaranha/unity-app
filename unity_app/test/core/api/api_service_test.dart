import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:unity_app/core/api/api_service.dart';

void main() {
  group('ApiService', () {
    test('returns decoded JSON on 200', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          '{"ok":true}',
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final api = ApiService(
        client: mockClient,
        baseUrl: 'http://localhost:3000',
      );
      final resp = await api.get('/test');
      expect(resp, isA<Map>());
      expect(resp['ok'], true);
    });

    test('throws ApiException on non-2xx', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          '{"message":"Not found"}',
          404,
          headers: {'content-type': 'application/json'},
        );
      });

      final api = ApiService(
        client: mockClient,
        baseUrl: 'http://localhost:3000',
      );
      expect(
        () async => await api.get('/notfound'),
        throwsA(isA<ApiException>()),
      );
    });
  });
}
