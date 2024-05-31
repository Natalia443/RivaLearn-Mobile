class Deck {
  Deck({
    required this.name,
    required this.deckId,
  });

  factory Deck.fromJson(Map<String, dynamic> json) {
    return Deck(
      name: json['name'] as String,
      deckId: json['deck_id'] as int,
    );
  }

  final String name;
  final int deckId;
}
