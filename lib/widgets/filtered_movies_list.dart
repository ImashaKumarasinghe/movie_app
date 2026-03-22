import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screeens/movie_details.dart';

class FilteredMoviesList extends StatelessWidget {
  final List<MovieModel> filteredMovies;

  const FilteredMoviesList({
    super.key,
    required this.filteredMovies,
  });

  @override
  Widget build(BuildContext context) {
    if (filteredMovies.isEmpty) {
      return const Center(
        child: Text('No matching movies found'),
      );
    }

    return ListView.builder(
      itemCount: filteredMovies.length,
      itemBuilder: (context, index) {
        final movie = filteredMovies[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: movie.posterPath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      '${ApiConstants.posterBaseUrl}${movie.posterPath}',
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.movie),
            title: Text(movie.title),
            subtitle: Text(
              movie.releaseDate.isNotEmpty
                  ? 'Release: ${movie.releaseDate}'
                  : 'No release date',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetails(movie: movie),
                ),
              );
            },
          ),
        );
      },
    );
  }
}