import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    final PageController _pageController = PageController(initialPage: 0);
    int _selectedIndex = 0;

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
                children: const [
                    Center(
                        child: Text('Welcome to Movie App 1!'),
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