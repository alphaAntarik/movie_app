import 'package:flutter/material.dart';
import 'package:movie_app/widgets/movielist.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'now playing'),
              Tab(text: 'top rated'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MovieListScreen(
              item: 'now_playing',
            ),
            MovieListScreen(
              item: 'top_rated',
            ),
          ],
        ),
      ),
    );
  }
}
