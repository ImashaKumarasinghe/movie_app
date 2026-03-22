import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screeens/movie_details.dart';

class HorizontalViewScroll extends StatelessWidget {
  final List<MovieModel> movies;

  const HorizontalViewScroll({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const Center(
        child: Text('No movies found'),
      );
    }

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetails(movie: movie),
                ),
              );
            },
            child: Container(
              width: 140,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: movie.posterPath != null
                          ? Image.network(
                              '${ApiConstants.posterBaseUrl}${movie.posterPath}',
                              width: 140,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: Colors.grey,
                              child: const Center(
                                child: Icon(Icons.image_not_supported),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}