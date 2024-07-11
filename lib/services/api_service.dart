import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class ApiService {
  final String baseUrl = "https://api.jikan.moe/v4";
  List<Pokemon> lista = [];

  Future<List<Pokemon>> fetchAnimeList() async {
    final response = await http.get(Uri.parse('$baseUrl/anime?q=boku no hero&sfw?limit=21'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['data'];
      for (int i = 0; i < results.length && i < 21; i++) {
        Pokemon dato = Pokemon(title: results[i]['title'],url: results[i]['images']['jpg']['image_url']);
        lista.add(dato);
      }
      return lista;
    } else {
      throw Exception('Failed to load result');
    }
  }
}
