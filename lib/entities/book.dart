class Book {
  String title;
  String? image;
  String text;

  Book({required this.title, this.image, required this.text});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      image: json['formats']['image/jpeg'],
      text: json['formats']['text/plain; charset=us-ascii'],
    );
  }
}
