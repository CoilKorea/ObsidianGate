class Game {
  final String title;
  final String slug;

  Game({required this.title, required this.slug});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
    );
  }
}
