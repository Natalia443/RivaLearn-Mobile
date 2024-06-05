class Flashcard {
  Flashcard({
    required this.id,
    required this.vocab,
    required this.vocabExample,
    required this.vocabExampleTranslated,
    required this.vocabTranslated,
  });

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      id: json['id'] as String,
      vocab: json['vocab'] as String,
      vocabExample: json['vocab_example'] as String,
      vocabExampleTranslated: json['vocab_example_translated'] as String,
      vocabTranslated: json['vocab_translated'] as String,
    );
  }

  String id;
  String vocab;
  String vocabTranslated;
  String vocabExample;
  String vocabExampleTranslated;
}
