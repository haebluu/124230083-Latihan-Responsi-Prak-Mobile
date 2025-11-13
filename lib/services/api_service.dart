import 'package:dio/dio.dart';
import '../models/anime_model.dart';

class ApiService {
  final Dio _dio = Dio();
  static const String _baseUrl = 'https://api.jikan.moe/v4';

  Future<List<AnimeModel>> fetchTopAnime() async {
    try {
      final response = await _dio.get('$_baseUrl/top/anime');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => AnimeModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load top anime');
      }
    } on DioException catch (e) {
      // Handle Dio errors (e.g., network issues)
      throw Exception('Failed to connect to API: ${e.message}');
    } catch (e) {
      // Handle other errors
      rethrow;
    }
  }
}