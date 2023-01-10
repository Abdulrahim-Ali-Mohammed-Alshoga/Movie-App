import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../business_logic/cubit/search_movie_cubit.dart';
import '../../business_logic/cubit/search_movie_state.dart';
import '../../constants/font.dart';
import '../../constants/mycolor.dart';
import '../../data/models/movie.dart';
import '../widgets/app_bar_search_widget.dart';
import '../widgets/grid_title_widget.dart';
import '../widgets/text_form_field_widget.dart';

class SearchMovieScreen extends StatefulWidget {
  const SearchMovieScreen({Key? key}) : super(key: key);

  @override
  State<SearchMovieScreen> createState() => _SearchMovieScreenState();
}

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  late List<Movie> movies;

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarSearchWidget(),
        body: BlocBuilder<SearchMovieCubit, SearchMovieState>(
            builder: (context, state) {
          if (state is SearchMovieInitialState) {
            movies = BlocProvider.of<SearchMovieCubit>(context).movies;
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Icon(Icons.search,color: MyColors.white,size: 37,),
                SizedBox(height: 10.h,),
                Text("Enter the movie name...",style: TextStyle(fontFamily: MyFont.titleFont,color: MyColors.white,fontSize: 22.sp),)]),
            );
          }
          else if (state is SearchMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: MyColors.deepOrange,
              ),
            );
          }
          else  if (state is SearchMovieSuccess) {
            movies = BlocProvider.of<SearchMovieCubit>(context).movies;
            return GridView.builder(
              shrinkWrap: true,
              controller: scrollController,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, index) {
// if(index+1==movies.length){
//
//   isLoading=true;
//   print(5555555555);
// }
                return GridTitleWidget(movie: movies[index],);
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .8,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1),
            );
          } else {
            return Center(
              child: SizedBox(
                height: .1.h,
              ),
            );
          }
        }));
  }
}
