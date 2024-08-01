import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});
 
  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}
 
class _MoviesScreenState extends State<MoviesScreen> {
  final myMovies = [
    {
      "name": "Bhooth Police",
      "posterUrl":
          "https://upload.wikimedia.org/wikipedia/en/4/4f/Bhoot_Police_film_poster.jpg",
      "desc":
          "Brothers Vibhooti and Chiraunji are assigned a seemingly ordinary case of hunting down demonic spirits in a remote village. However, they soon realise that there is nothing ordinary about this case.",
    },
    {
      "name": "Ted",
      "posterUrl":
          "https://upload.wikimedia.org/wikipedia/en/thumb/3/3d/Ted_2_poster.png/220px-Ted_2_poster.png",
      "desc":
          "A wish comes true for John when his teddy bear, Ted, comes to life. When he plans to move in with his girlfriend, Ted, who is not prepared for the change, unintentionally ruins their relationship.",
    },
    {
      "name": "Kakuda",
      "posterUrl":
          "https://media.assettype.com/outlookindia/2024-07/af49e595-052a-41b6-bfbe-7fea16251d07/5.jpg?w=1200&ar=40%3A21&auto=format%2Ccompress&ogImage=true&mode=crop&enlarge=true&overlay=false&overlay_position=bottom&overlay_width=100",
      "desc":
          "A town is trapped in time by a curse and 3 of its inhabitants face a ghost that makes them question superstition, tradition and love.",
    },
    {
      "name": "Anyone but You",
      "posterUrl":
          "https://preview.redd.it/anyone-but-you-predictions-v0-e1cbqy6cm23c1.jpg?width=640&crop=smart&auto=webp&s=286816387acff934df00c495164f9be8559ae79e",
      "desc":
          "Despite having an amazing first date, Bea and Ben's initial attraction quickly turns sour. When they unexpectedly find themselves at a destination wedding in Australia, the pair pretend to be the perfect couple to keep up appearances.",
    },
    {
      "name": "Ra.One",
      "posterUrl":
          "https://upload.wikimedia.org/wikipedia/en/5/58/Ra.Oneposter.jpg",
      "desc":
          "Shekhar, a game developer, is on the verge of introducing his next big thing. However, he pays with his life when his robot Ra.One goes rogue and the only one to stop it is his virtual self, G.One.",
    },
    {
      "name": "Wanda Vision",
      "posterUrl":
          "https://m.media-amazon.com/images/M/MV5BZGEwYmMwZmMtMTQ3MS00YWNhLWEwMmQtZTU5YTIwZmJjZGQ0XkEyXkFqcGdeQXVyMTI5MzA5MjA1._V1_.jpg",
      "desc":
          "Blends the style of classic sitcoms with the MCU, in which Wanda Maximoff and Vision - two super-powered beings living their ideal suburban lives - begin to suspect that everything is not as it seems.",
    },
    {
      "name": "Laapataa Ladies",
      "posterUrl":
          "https://m.media-amazon.com/images/M/MV5BMGFjOGQ3MWItYzcwNS00ZTYxLWE5MmYtOWVkMWE1NmM1MzM1XkEyXkFqcGdeQXVyMTY1MjAwNDU0._V1_.jpg",
      "desc":
          "Two newlyweds find themselves inadvertently separated from their husbands moments after their respective weddings.",
    },
    {
      "name": "Bhaag Jhonny",
      "posterUrl":
          "https://lh5.googleusercontent.com/proxy/Ys7s0_WjCeKvCJ2lCeOhprdXGH2YjLhbOw8ojCPpIiE_0gzR-IK0fZQOMNYMbjraPFCQmBMWe_o0D1OYzBRp_ap0CDcKJt9R1SeEF5aeI7L27L_Kv4yqlA",
      "desc":
          "Bangkok-based Johnny engages in a treachery that his employer, Ramona, witnesses. She blackmails him into killing a girl, Tanya, but suddenly something unexpected happens.",
    }
  ];
 
  Box? box;
 
  @override
  void initState() {
    super.initState();
    setUpBox();
  }
 
  Future<void> setUpBox() async {
    box = await Hive.openBox("moviesBox");
    if (!box!.containsKey('moviesPlace')) {
      await box!.put('moviesPlace', myMovies);
    }
    setState(() {});
  }
 
  @override
  Widget build(BuildContext context) {
    if (box == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
 
    final moviesList = (box!.get('moviesPlace') as List).cast<Map>();
 
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: moviesList.length,
          itemBuilder: (context, i) {
            final eachMovie = Map<String, dynamic>.from(moviesList[i]);
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                color: const Color.fromARGB(255, 248, 240, 240),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          eachMovie["name"]!,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      CachedNetworkImage(
                        imageUrl: eachMovie["posterUrl"]!,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          eachMovie["desc"]!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
 