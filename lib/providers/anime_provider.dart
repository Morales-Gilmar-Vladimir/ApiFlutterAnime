import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../services/api_service.dart';

class AnimeProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Pokemon> _animeList = [];
  bool _isLoading = false;

  List<Pokemon> get animeList => _animeList;
  bool get isLoading => _isLoading;

  Future<void> fetchAnime() async {
    _isLoading = true;
    notifyListeners();

    _animeList = await _apiService.fetchAnimeList();
    _isLoading = false;
    notifyListeners();
  }
}
