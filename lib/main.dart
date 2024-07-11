import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/anime_provider.dart';
import 'models/pokemon.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AnimeProvider()),
      ],
      child: MaterialApp(
        title: 'Api Anime - Gilmar Morales',
        home: AnimeListScreen(),
      ),
    );
  }
}

class AnimeListScreen extends StatelessWidget {
  const AnimeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime List - Boku no hero'),
      ),
      body: Consumer<AnimeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75, // Ajuste para hacer los elementos más pequeños
            ),
            itemCount: provider.animeList.length,
            itemBuilder: (context, index) {
              Pokemon anime = provider.animeList[index];
              return Card(
                elevation: 2.0,
                margin: const EdgeInsets.all(6.0), // Ajuste del margen para hacerlo más pequeño
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image.network(
                        anime.url,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0), // Ajuste del relleno para hacerlo más pequeño
                      child: Text(
                        anime.title,
                        style: const TextStyle(
                          fontSize: 14.0, // Ajuste del tamaño de fuente
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<AnimeProvider>(context, listen: false).fetchAnime();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}