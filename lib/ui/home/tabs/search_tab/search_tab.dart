import 'package:flutter/material.dart';
import 'package:movie_app/api/api_manager.dart';
import 'package:movie_app/api/model/available_movies_response.dart';
import 'package:movie_app/api/model/movies.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();
  List<Movies> _movies = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDefaultMovies();
  }

  void _loadDefaultMovies() async {
    setState(() {
      _isLoading = true;
    });
    var response = await ApiManager.getMovies(queryTerm: 'Action');
    setState(() {
      _isLoading = false;
      if (response != null && response.data?.movies != null) {
        _movies = response.data!.movies!;
      }
    });
  }

  void _searchMovies(String query) async {
    if (query.isEmpty) {
      _loadDefaultMovies();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    var response = await ApiManager.getMovies(queryTerm: query);

    setState(() {
      _isLoading = false;
      if (response != null && response.data?.movies != null) {
        _movies = response.data!.movies!;
      } else {
        _movies = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 12),
            TextField(
              controller: _searchController,
              onChanged: _searchMovies,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: 'Search for a movie...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                itemCount: _movies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  var movie = _movies[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        movie.mediumCoverImage != null
                            ? Image.network(movie.mediumCoverImage!, fit: BoxFit.cover)
                            : Container(color: Colors.grey, child: const Icon(Icons.movie)),
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  movie.rating?.toString() ?? '0.0',
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.star, color: Colors.amber, size: 14),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}