import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/anime_model.dart';
import '../services/shared_pref_service.dart';

class FavoriteController extends ChangeNotifier {
  final SharedPrefService _sharedPrefService = SharedPrefService();

  List<AnimeModel> _favorites = [];
  List<AnimeModel> get favorites => _favorites;

  Future<void> loadFavorites() async {
    final favoritesJson = await _sharedPrefService.getFavorites();
    _favorites = favoritesJson
        .map((e) => AnimeModel.fromMap(jsonDecode(e) as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  bool isFavorite(int malId) {
    return _favorites.any((anime) => anime.malId == malId);
  }

  Future<void> toggleFavorite(AnimeModel anime) async {
    if (isFavorite(anime.malId)) {
      _favorites.removeWhere((item) => item.malId == anime.malId);
    } else {
      _favorites.add(anime);
    }

    await _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final favoritesJson = _favorites.map((e) => jsonEncode(e.toMap())).toList();
    await _sharedPrefService.saveFavorites(favoritesJson);
  }
}