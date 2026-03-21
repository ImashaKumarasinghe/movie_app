import 'package:flutter/material.dart';
import 'package:movie_app/screeens/pages/home_page.dart';

class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    final PageController _pageController = PageController(initialPage: 0);
    int _selectedIndex = 0;

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


    @override
    void dispose() {
        _pageController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Movie App'),
            ),
            body: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                    setState(() {
                        _selectedIndex = index;
                    });
                },
                children: [
                    Center(
                        child: HomePage(),
                    ),
                    Center(
                        child: Text('Welcome to Movie App 2!'),
                    ),
                ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.blueGrey,
                onTap: (index) {
                    setState(() {
                        _selectedIndex = index;
                    });
                    _pageController.jumpToPage(index);
                },
                items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.movie),
                        label: 'Movies',
                    ),
                ],
            ),
        );
    }
}