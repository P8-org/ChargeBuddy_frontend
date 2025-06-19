class ElectricityPrices {
  final int hour;
  final double price;

  ElectricityPrices({required this.hour, required this.price});

  factory ElectricityPrices.fromJson(Map<String, dynamic> json) {
    return ElectricityPrices(
      hour: DateTime.parse(json['HourDK']).hour,
      price: (json['TotalPriceDKK'] as num).toDouble(),
    );
  }
}
