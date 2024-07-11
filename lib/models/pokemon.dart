class Pokemon {
  final String url;
  final String title;

  Pokemon({required this.title, required this.url});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      title: json['title'],
      url: json['images']['jpg']['image_url'],
    );
  }
}