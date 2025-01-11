class Cabin {
  final String name;
  final String image;
  final String description;
  final List<String> amenity;  // Keep this consistent with the API response
  final double pricesWeekday;
  final double pricesWeekend;

  Cabin({
    required this.name,
    required this.image,
    required this.description,
    required this.amenity,  // Updated to 'amenity' to match the API response
    required this.pricesWeekday,
    required this.pricesWeekend,
  });

  factory Cabin.fromJson(Map<String, dynamic> json) {
    double safeToDouble(dynamic value) {
      if (value == null) {
        return 0.0;
      } else if (value is int) {
        return value.toDouble();
      } else if (value is double) {
        return value;
      } else {
        return 0.0;
      }
    }

    return Cabin(
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      amenity: List<String>.from(json['amenity'] ?? []), // Use 'amenity' as in the API
      pricesWeekday: safeToDouble(json['prices_weekday']),
      pricesWeekend: safeToDouble(json['prices_weekend']),
    );
  }
}
