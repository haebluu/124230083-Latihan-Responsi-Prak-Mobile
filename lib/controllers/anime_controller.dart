import 'package:flutter/material.dart';
import '../models/anime_model.dart';
import '../services/api_service.dart';

class AnimeController extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<AnimeModel> _topAnime = [];
  List<AnimeModel> get topAnime => _topAnime;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchTopAnime() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _topAnime = await _apiService.fetchTopAnime();
    } catch (e) {
      _errorMessage = 'Failed to load data: ${e.toString()}';
    }

    _isLoading = false;
    notifyListeners();
  }
}