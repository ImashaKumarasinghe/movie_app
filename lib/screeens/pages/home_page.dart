import 'package:flutter/material.dart';
import 'package:movie_app/services/movie_services.dart';
class HomePage extends StatefulWidget {
    
    
    @override
    State<HomePage> createState() => HomePageState();

}
 Widget SearchBar() {
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search movies...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[800],
                ),
            ),
        );
    }

class HomePageState extends State<HomePage> {


@override
    void initState() {
        super.initState();
        printData();
    }

    Future<void> printData() async {
        MovieServices movieServices = MovieServices();
        final data = await movieServices.popularMovies();
        print(data.toString());
    }

    @override
    Widget build(BuildContext context) {
        return SingleChildScrollView(
            child:Column(children:[
                SizedBox(height: 30),
                SearchBar(),
            ])
           
        );
    }
}
