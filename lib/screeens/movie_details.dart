import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieDetails extends StatelessWidget {
	final MovieModel movie;

	const MovieDetails({
		super.key,
		required this.movie,
	});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(movie.title),
			),
			body: SingleChildScrollView(
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						if (movie.backdropPath != null)
							Image.network(
								'${ApiConstants.backdropBaseUrl}${movie.backdropPath}',
								width: double.infinity,
								fit: BoxFit.cover,
							),
						Padding(
							padding: const EdgeInsets.all(16),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Text(
										movie.title,
										style: const TextStyle(
											fontSize: 24,
											fontWeight: FontWeight.bold,
										),
									),
									const SizedBox(height: 8),
									Text(
										'Release: ${movie.releaseDate.isEmpty ? 'Unknown' : movie.releaseDate}',
									),
									const SizedBox(height: 4),
									Text('Rating: ${movie.voteAverage.toStringAsFixed(1)} / 10'),
									const SizedBox(height: 16),
									const Text(
										'Overview',
										style: TextStyle(
											fontSize: 18,
											fontWeight: FontWeight.w600,
										),
									),
									const SizedBox(height: 8),
									Text(
										movie.overview.isEmpty ? 'No overview available.' : movie.overview,
									),
								],
							),
						),
					],
				),
			),
		);
	}
}
