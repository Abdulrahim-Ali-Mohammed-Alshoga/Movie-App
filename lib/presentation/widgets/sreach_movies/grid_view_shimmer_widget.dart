import 'package:flutter/material.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/presentation/widgets/sreach_movies/grid_title_shimmer_widget.dart';
import '../grid_title_widget.dart';
class GridViewWidget extends StatelessWidget {
   GridViewWidget({Key? key,this.isShimmer=false, this.movies, this.scrollController}) : super(key: key);
  ScrollController? scrollController;
 bool isShimmer;
    List<Movie>? movies;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(

      cacheExtent: 100,
      shrinkWrap: true,
       controller: scrollController,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: isShimmer?8:movies?.length,
      itemBuilder: (BuildContext context, index) {
        return  isShimmer?const GridTitleShimmerWidget():GridTitleWidget(
         movie: movies![index]

        );
      },
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .8,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1),
    );
  }
}
