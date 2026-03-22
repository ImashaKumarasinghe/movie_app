import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/movie_services.dart';
import 'package:movie_app/widgets/filtered_movies_list.dart';
import 'package:movie_app/widgets/horizontal_view_scroll.dart';
import 'package:movie_app/widgets/movie_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MovieService movieService = MovieService();
  final TextEditingController searchController = TextEditingController();

  List<MovieModel> popularMovies = [];
  List<MovieModel> topRatedMovies = [];
  List<MovieModel> upcomingMovies = [];
  List<MovieModel> filteredMovies = [];

  bool isLoading = true;
  bool isSearchEmpty = true;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      popularMovies = await movieService.popularMovies();
      topRatedMovies = await movieService.topRatedMovies();
      upcomingMovies = await movieService.upcomingMovies();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load movies: $e'),
        ),
      );
    }
  }

  void filterMovies(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        isSearchEmpty = true;
        filteredMovies = [];
      });
      return;
    }

    final allMovies = [...popularMovies, ...topRatedMovies, ...upcomingMovies];

    final uniqueMovies = <int, MovieModel>{};
    for (var movie in allMovies) {
      uniqueMovies[movie.id] = movie;
    }

    final results = uniqueMovies.values.where((movie) {
      return movie.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      isSearchEmpty = false;
      filteredMovies = results;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: filterMovies,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();
                          filterMovies('');
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : !isSearchEmpty
                      ? FilteredMoviesList(filteredMovies: filteredMovies)
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Top Rated',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              MovieSlider(topRatedMovies: topRatedMovies),
                              const SizedBox(height: 20),
                              const Text(
                                'Upcoming Movies',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              HorizontalViewScroll(movies: upcomingMovies),
                              const SizedBox(height: 20),
                              const Text(
                                'Popular Movies',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              HorizontalViewScroll(movies: popularMovies),
                            ],
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}