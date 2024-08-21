import 'dart:convert';
import 'package:http/http.dart' as http;

class Article {
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String datedepublication;

  Article({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
    required this.datedepublication,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'Titre non disponible',
      description: json['description'] ?? 'Description non disponible',
      urlToImage: json['urlToImage'] ?? '',
      url: json['url'] ?? '',
      datedepublication: json['publishedAt'] ?? 'Date non disponible',
    );
  }
}


Future<List<Article>> fetchArticles() async {
  final String apiUrl = 'https://newsapi.org/v2/everything?q=tesla&from=2024-07-21&sortBy=publishedAt&apiKey=26e95aa3d73043dcba151649e699c9ab';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> articlesJson = jsonResponse['articles'];

      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Échec de la récupération des articles');
    }
  } catch (e) {
    print('Erreur lors de la récupération des articles: $e');
    return []; // Renvoie une liste vide en cas d'erreur
  }
}
