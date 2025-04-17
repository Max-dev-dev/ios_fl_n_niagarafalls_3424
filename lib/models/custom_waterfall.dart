class CustomWaterfallEntry {
  final DateTime date;
  final String? imagePath;
  final String title;
  final String location;
  final String description;
  final List<String> emotions;
  final int emotionIntensity;
  final String? weather;
  final List<String> impressionTypes;
  final bool addToBestMoments;

  CustomWaterfallEntry({
    required this.date,
    this.imagePath,
    required this.title,
    required this.location,
    required this.description,
    required this.emotions,
    required this.emotionIntensity,
    this.weather,
    required this.impressionTypes,
    required this.addToBestMoments,
  });

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'imagePath': imagePath,
        'title': title,
        'location': location,
        'description': description,
        'emotions': emotions,
        'emotionIntensity': emotionIntensity,
        'weather': weather,
        'impressionTypes': impressionTypes,
        'addToBestMoments': addToBestMoments,
      };

  factory CustomWaterfallEntry.fromJson(Map<String, dynamic> json) {
    return CustomWaterfallEntry(
      date: DateTime.parse(json['date']),
      imagePath: json['imagePath'],
      title: json['title'],
      location: json['location'],
      description: json['description'],
      emotions: List<String>.from(json['emotions']),
      emotionIntensity: json['emotionIntensity'],
      weather: json['weather'],
      impressionTypes: List<String>.from(json['impressionTypes']),
      addToBestMoments: json['addToBestMoments'],
    );
  }
}
