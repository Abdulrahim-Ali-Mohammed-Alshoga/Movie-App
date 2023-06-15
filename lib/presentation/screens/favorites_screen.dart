import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/favorite/favorite_cubit.dart';
import '../../business_logic/cubit/favorite/favorite_state.dart';
import '../../data/models/movie.dart';
import '../widgets/empty_widget.dart';
import '../widgets/sreach_movies/grid_view_shimmer_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // box.clear();
  }

  List<Movie> movies = [];
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FavoriteCubit>(context).getMovieFavorite();
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        movies = BlocProvider.of<FavoriteCubit>(context)
            .movieFavorites
            .reversed
            .toList();
        if (state is FavoriteSuccess || state is FavoriteAdd) {
          return ScrollConfiguration(
              behavior:
                  const MaterialScrollBehavior().copyWith(overscroll: false),
              child: GridViewWidget(
                scrollController: scrollController,
                movies: movies,
              ));
        } else {
          return EmptyWidget(
            icon: Icons.favorite,
            title: "Your Favorites is Empty",
          );
        }
      },
      listener: (context, state) {
        if (state is FavoriteAdd) {
          print(movies.length);
          if (movies.isNotEmpty) {
            scrollController.jumpTo(0);
          }
        }
      },
    );
  }
}
// void initState() {
//   listLength=getLength();
//   scrollController.animateTo(
//       scrollController.position.maxScrollExtent,
//       duration: Duration(milliseconds: 500),
//       curve: Curves.fastOutSlowIn);
//   // TODO: implement initState
//   super.initState();
//   // box.clear();
// }

// late List<MovieHive> movies;
// getLength(){
//   return boxMovie.length;
// }
// jumpForStart(int length){
//   if(listLength<length){
//     setState(() {
//       scrollController.jumpTo(0);
//     });
//
//     listLength=length;
//   }
//
// }
// ScrollController scrollController = ScrollController();
// var boxMovie = Hive.box<MovieHive>(MovieFavoriteHiveDB.movieDB);
// late int listLength;
// @override
// Widget build(BuildContext context) {
//
//   return ValueListenableBuilder(valueListenable: boxMovie.listenable(), builder: (context, box, widget) {
//     print(box.length);
//     jumpForStart(box.length);
//     if(box.isEmpty){
//       return EmptyWidget(
//         icon: Icons.favorite,
//         title: "Your Favorites is Empty",
//       );
//     }
//     else{
//       return GridView.builder(
//
//         cacheExtent: 100,
//         shrinkWrap: true,
//         controller: scrollController,
//         physics: const ClampingScrollPhysics(),
//         padding: EdgeInsets.zero,
//         itemCount: box.length,
//         itemBuilder: (BuildContext context, index) {
// // if(index+1==movies.length){
// //
// //   isLoading=true;
// //   print(5555555555);
// // }
//           MovieHive movies=box.getAt(index)!;
//           return GridTitleWidget(
//             isFavorites: true,
//             rating: movies.rating,
//             id: movies.id,
//             image: movies.image,
//             productionData: movies.productionData,
//           );
//         },
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: .8,
//             crossAxisSpacing: 1,
//             mainAxisSpacing: 1),
//       );
//     }
//   },);
