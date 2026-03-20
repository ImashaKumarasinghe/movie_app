import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => HomeScreenState();

}
class HomeScreenState extends State<HomeScreen> {
    final PageController pageController = PageController(initialPage: 0);
    late int currentIndex = 0;


    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Movie App'),
            ),
            body: PageView(
                 children :const [
                     Center(
                        child: Text('Welcome to Movie App 1!'),
                     ),
                     Center(
                        child: Text('Welcome to Movie App 2!'),
                    ),
                ],
            ),
        );
    }
}