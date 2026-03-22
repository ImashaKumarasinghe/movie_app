import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screeens/movie_details.dart';

class MovieSlider extends StatelessWidget {
  final List<MovieModel> topRatedMovies;

  const MovieSlider({
    super.key,
    required this.topRatedMovies,
  });

  @override
  Widget build(BuildContext context) {
    if (topRatedMovies.isEmpty) {
      return const Center(
        child: Text('No top rated movies found'),
      );
    }

    return CarouselSlider.builder(
      itemCount: topRatedMovies.length,
      itemBuilder: (context, index, realIndex) {
        final movie = topRatedMovies[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetails(movie: movie),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                movie.backdropPath != null
                    ? Image.network(
                        '${ApiConstants.backdropBaseUrl}${movie.backdropPath}',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: Colors.grey,
                        child: const Center(
                          child: Icon(Icons.image_not_supported),
                        ),
                      ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 220,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.85,
      ),
    );
  }
}