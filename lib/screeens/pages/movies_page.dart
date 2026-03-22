import 'package:flutter/material.dart';

class MoviesPage extends StatelessWidget {
	const MoviesPage({super.key});

	@override
	Widget build(BuildContext context) {
		return const Scaffold(
			body: Center(
				child: Text(
					'Movies page',
					style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
				),
			),
		);
	}
}
