class ShadowQuizQuestion {
  final String shadowAsset;
  final List<ShadowQuizOption> options;

  ShadowQuizQuestion({
    required this.shadowAsset,
    required this.options,
  });
}

class ShadowQuizOption {
  final String imageAsset;
  final bool isCorrect;

  ShadowQuizOption({
    required this.imageAsset,
    required this.isCorrect,
  });
}
