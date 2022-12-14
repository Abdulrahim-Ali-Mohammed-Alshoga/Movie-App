import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/constants/arguments.dart';
import 'package:movies/constants/mycolor.dart';
import 'package:movies/presentation/widgets/grid_title_widget.dart';

import '../../business_logic/cubit/movie_cubit.dart';
import '../../business_logic/cubit/movie_state.dart';
import '../../constants/font.dart';
import '../../data/models/movie.dart';

class ListMoviesScreen extends StatefulWidget {
  ListMoviesScreen({Key? key, required this.listMovies}) : super(key: key);
  ListMovies listMovies;


  @override
  State<ListMoviesScreen> createState() => _ListMoviesScreenState();
}

class _ListMoviesScreenState extends State<ListMoviesScreen> {
  final scrollController=ScrollController();
 late List<Movie>movies;

 Future getMovies() async{
   BlocProvider.of<MovieCubit>(context).getAllMovies(widget.listMovies.genre.id,0);

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.listMovies.genre.id);
    scrollController.addListener(() {
      if(scrollController.offset==scrollController.position.maxScrollExtent){
       getMovies();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.listMovies.genre.name,style: TextStyle(fontFamily:MyFont.titleFont ),),
        centerTitle: true,
      ),
      body:BlocBuilder<MovieCubit, MovieState>(
         builder: (context, state) {
          if(state is MovieSuccess){
            movies = BlocProvider.of<MovieCubit>(context).movies;
            return   GridView.builder(
              shrinkWrap: true,
              controller: scrollController,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount:movies.length,
              itemBuilder: (BuildContext context, index) {
              //  print(index);
// if(index+1==movies.length){
//
//   isLoading=true;
//   print(5555555555);
// }
                return GridTitleWidget(movie:movies[index],);
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:.8,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1),
            );
          }
           else{
            return Center(
              child: SizedBox(
                height: .1.h,
              ),
            );
          }
         },
      )

    );
  }
}
