import 'package:http/http.dart' as http;
import 'dart:convert';
import '../viewmodels/electricity_prices.dart';
import 'package:ev_charge/core/platform_helper.dart';

class ElectricityPricesService {
  final http.Client client;
  ElectricityPricesService(this.client);

  Future<List<ElectricityPrices>> fetchElectricityPrices() async {
    final url = getBaseUrl() + '/power';
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => ElectricityPrices.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load electricity prices');
    }
  }
}
