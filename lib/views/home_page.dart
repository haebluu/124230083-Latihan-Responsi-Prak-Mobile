import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/anime_controller.dart';
import 'detail_page.dart';
// ... (Bagian import)

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final animeController = Provider.of<AnimeController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Anime'),
        backgroundColor: Colors.deepPurple,
      ),
      body: animeController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : animeController.errorMessage != null
              ? Center(child: Text('Error: ${animeController.errorMessage}'))
              : ListView.builder(
                  itemCount: animeController.topAnime.length,
                  itemBuilder: (context, index) {
                    final anime = animeController.topAnime[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Card( // <--- Tambahkan Card di sini
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          leading: SizedBox(
                            width: 60,
                            height: 90,
                            child: CachedNetworkImage(
                              imageUrl: anime.imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.broken_image),
                            ),
                          ),
                          title: Text(
                            anime.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 16),
                                  const SizedBox(width: 4),
                                  Text('Score: ${anime.score.toStringAsFixed(2)}'),
                                ],
                              ),
                              Text(
                                'Type: ${anime.type ?? '-'} | Ep: ${anime.episodes ?? '-'}',
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(anime: anime),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}