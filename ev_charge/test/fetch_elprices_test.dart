import 'package:ev_charge/core/get_electricity_prices.dart';
import 'package:ev_charge/viewmodels/electricity_prices.dart';
import 'package:ev_charge/core/platform_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'fetch_elprices_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('fetchElectricityPrices', () {
    late MockClient mockClient;
    late ElectricityPricesService service;

    setUp(() {
      // Initialize MockClient before each test
      mockClient = MockClient();
      service = ElectricityPricesService(mockClient);
    });
    final url = '${getBaseUrl()}/power';
    test(
      'return electricity prices if the http call completes successfully',
      () async {
        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(

          mockClient.get(Uri.parse(url)),
        ).thenAnswer(
          (_) async => http.Response(
            '[{"HourDK": "2025-04-01T00:00:00", "SpotPriceDKK": 50.0}, '
            '{"HourDK": "2025-04-01T01:00:00", "SpotPriceDKK": 45.0}]',
            200,
          ),
        );

        // Create the service and fetch the electricity prices
        final prices = await service.fetchElectricityPrices();

        // Check that the data is correctly parsed
        expect(prices, isA<List<ElectricityPrices>>());
        expect(prices.length, 2);
        expect(prices[0].hour, 0);
        expect(prices[0].price, 50.0);
        expect(prices[1].hour, 1);
        expect(prices[1].price, 45.0);
      },
    );

    test('throws an exception if the http call completes with an error', () {
      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(
        mockClient.get(Uri.parse('http://10.0.2.2:8000/power')),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(
        () async => await service.fetchElectricityPrices(),
        throwsException,
      );
    });
  });
}
