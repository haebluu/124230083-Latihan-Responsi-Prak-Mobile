import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/anime_model.dart';
import '../controllers/favorite_controller.dart';

class DetailPage extends StatelessWidget {
  final AnimeModel anime;
  const DetailPage({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    final favoriteController = Provider.of<FavoriteController>(context);
    final isFavorite = favoriteController.isFavorite(anime.malId);

    return Scaffold(
      appBar: AppBar(
        title: Text(anime.title),
        backgroundColor: Color.fromRGBO(206, 1, 88, 1),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              favoriteController.toggleFavorite(anime);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isFavorite
                      ? 'Removed from Favorites'
                      : 'Added to Favorites'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // --- Poster dan Judul ---
            Center(
              child: CachedNetworkImage(
                imageUrl: anime.imageUrl,
                height: 300,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 300,),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              anime.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (anime.titleEnglish != null && anime.titleEnglish!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  anime.titleEnglish!,
                  style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),
                ),
              ),
            const SizedBox(height: 10),

            // --- Score ---
            Center( 
              child: Row(
                mainAxisSize: MainAxisSize.min, 
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 26),
                  const SizedBox(width: 5),
                  Text(
                    ' ${anime.score.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ), 
            const SizedBox(height: 20),

            // --- Detail Tambahan ---
            const Text(
              'Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildInfoRow('Type', anime.type),
            _buildInfoRow('Episodes', anime.episodes?.toString()),
            _buildInfoRow('Rating', anime.rating),
            _buildInfoRow('Status', anime.status),
            _buildInfoRow('Year', anime.year?.toString()),
            _buildInfoRow('Genres', anime.genres.join(', ')),

            const SizedBox(height: 20),

            // --- Sinopsis ---
            const Text(
              'Synopsis',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Text(
              anime.synopsis,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    if (value == null || value.isEmpty || value == '0') return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}