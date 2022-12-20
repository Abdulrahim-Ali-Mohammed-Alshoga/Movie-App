import 'package:flutter/material.dart';
import 'package:movies/constants/arguments.dart';
import 'package:movies/presentation/widgets/grid_title_widget.dart';

import '../../constants/font.dart';
import '../../data/models/movie.dart';

class ListMoviesScreen extends StatefulWidget {
  ListMoviesScreen({Key? key, required this.listMovies}) : super(key: key);
  ListMovies listMovies;


  @override
  State<ListMoviesScreen> createState() => _ListMoviesScreenState();
}

class _ListMoviesScreenState extends State<ListMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.listMovies.genre,style: TextStyle(fontFamily:MyFont.titleFont ),),
        centerTitle: true,
      ),
      body: GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: widget.listMovies.movies.length,
        itemBuilder: (BuildContext context, index) {

          return GridTitleWidget(movie: widget.listMovies.movies[index]);
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio:.8,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1),
      ),
    );
  }
}
