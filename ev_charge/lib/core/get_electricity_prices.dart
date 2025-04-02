import 'package:http/http.dart' as http;
import 'dart:convert';
import '../viewmodels/electricity_prices.dart';

// URL for Android:
// http://127.0.0.1:8000/power

class ElectricityPricesService {
  final http.Client client;
  ElectricityPricesService(this.client);

  Future<List<ElectricityPrices>> fetchElectricityPrices() async {
    final response = await client.get(Uri.parse('http://10.0.2.2:8000/power'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => ElectricityPrices.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load electricity prices');
    }
  }
}
