class CurrencyRates {
  bool? success;
  int? timestamp;
  String? base;
  String? date;
  Map<String, double>? rates = {};

  CurrencyRates({
    this.success,
    this.timestamp,
    this.base,
    this.date,
    this.rates,
  });
  CurrencyRates.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    timestamp = json['timestamp']?.toInt();
    base = json['base']?.toString();
    date = json['date']?.toString();
    if (json["rates"] != null) {
      json["rates"].forEach((key, value) {
        Map<String, double> someData = {"$key": value.toDouble()};
        rates!.addAll(someData);
      });
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['timestamp'] = timestamp;
    data['base'] = base;
    data['date'] = date;
    data['rates'] = rates;
    return data;
  }
}
