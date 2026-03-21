import 'package:http/http.dart' as http;

class MovieServices {
    static const String _baseUrl = 'https://api.themoviedb.org/3';
    static const Map<String, String> _headers = {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMzBjODY4YTAwNTExZTZjOTg0YzNjODAyYTJlYjA2MyIsIm5iZiI6MTc3NDA4MTQ4OS43NTksInN1YiI6IjY5YmU1NWQxODE5YmQyMWNhZWE1ZTA4NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VMk08P7WomNBffAS6gyV_fs21ppYk-hi4TnJ2SrBfdM',
        'Accept': 'application/json',
    };

    Future<String> popularMovies() async {
        return _get(
            '$_baseUrl/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc',
            'popular movies',
        );
    }

    Future<String> topRatedMovies() async {
        return _get(
            '$_baseUrl/movie/top_rated?language=en-US&page=1',
            'top rated movies',
        );
    }

    Future<String> upcomingMovies() async {
        return _get(
            '$_baseUrl/movie/upcoming?language=en-US&page=1',
            'upcoming movies',
        );
    }

    Future<String> similarMovies(int movieId) async {
        return _get(
            '$_baseUrl/movie/$movieId/similar?language=en-US&page=1',
            'similar movies',
        );
    }

    Future<String> _get(String url, String label) async {
        final response = await http.get(Uri.parse(url), headers: _headers);
        if (response.statusCode == 200) {
            return response.body;
        }
        throw Exception('Failed to load $label (${response.statusCode})');
    }
}
