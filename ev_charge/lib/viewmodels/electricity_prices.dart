class ElectricityPrices {
  final int hour;
  final double price;

  static const double tax = 0.951;
  static const double convertToKwh = 1000.0;

  ElectricityPrices({required this.hour, required this.price});

  factory ElectricityPrices.fromJson(Map<String, dynamic> json) {
    return ElectricityPrices(
      hour: DateTime.parse(json['HourDK']).hour,
      price: (json['SpotPriceDKK'] as num).toDouble() / convertToKwh + tax,
    );
  }
}
