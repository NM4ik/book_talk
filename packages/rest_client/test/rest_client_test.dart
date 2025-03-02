import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rest_client/rest_client.dart';
import 'package:rest_client/src/rest_client_base.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('RestClientDio', () {
    late RestClientDio client;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      client = RestClientDio(
        baseUrl: 'https://api.example.com',
        headers: {},
        dio: mockDio,
      );
      registerFallbackValue(RequestOptions(path: ''));
    });

    test('send() should return successful RestResponse on 200 status',
        () async {
      final responsePayload = {
        'success': true,
        'message': 'Success',
        'data': {'id': 1, 'name': 'Test'},
      };

      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: responsePayload,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final response = await client.send(
        path: '/test',
        method: RestClientMethod.post,
        body: {'key': 'value'},
      );

      expect(response.success, isTrue);
      expect(response.data, containsPair('id', 1));
      expect(response.message, 'Success');
    });

    test('send() should handle DioException properly', () async {
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            data: {'success': false, 'message': 'Error'},
            statusCode: 400,
            requestOptions: RequestOptions(path: ''),
          ),
        ),
      );

      final response = await client.send(
        path: '/test',
        method: RestClientMethod.post,
      );

      expect(response.success, isFalse);
      expect(response.message, 'Error');
    });
  });
}
