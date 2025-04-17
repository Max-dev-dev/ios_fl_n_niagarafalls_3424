class WaterfallModel {
  final String name;
  final List<String> images;
  final List<String> categories;
  final double height;
  final double width;
  final String type;
  final String seasonality;
  final String description;
  final List<String> historicalFacts;
  final String features;

  WaterfallModel({
    required this.name,
    required this.images,
    required this.categories,
    required this.height,
    required this.width,
    required this.type,
    required this.seasonality,
    required this.description,
    required this.historicalFacts,
    required this.features,
  });

  factory WaterfallModel.fromJson(Map<String, dynamic> json) {
    return WaterfallModel(
      name: json['name'],
      images: List<String>.from(json['images']),
      categories: List<String>.from(json['categories']),
      height: (json['height'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      type: json['type'],
      seasonality: json['seasonality'],
      description: json['description'],
      historicalFacts: List<String>.from(json['historical_facts']),
      features: json['features'],
    );
  }
}

class FallsModel {
  final List<WaterfallModel> items;

  FallsModel({required this.items});

  factory FallsModel.fromJson(Map<String, dynamic> json) {
    return FallsModel(
      items: List<Map<String, dynamic>>.from(json['items'])
          .map((item) => WaterfallModel.fromJson(item))
          .toList(),
    );
  }
}
