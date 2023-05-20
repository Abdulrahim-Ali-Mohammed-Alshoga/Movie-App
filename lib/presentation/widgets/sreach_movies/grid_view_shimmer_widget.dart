import 'package:flutter/material.dart';
import 'package:movies/presentation/widgets/sreach_movies/grid_title_shimmer_widget.dart';
import '../grid_title_widget.dart';
class GridViewWidget extends StatelessWidget {
   GridViewWidget({Key? key,this.isShimmer=false, this.movies,required this.scrollController}) : super(key: key);
  ScrollController? scrollController;
 bool isShimmer;
    dynamic movies;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      cacheExtent: 100,
      shrinkWrap: true,
       controller: scrollController,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: isShimmer?8:movies.length,
      itemBuilder: (BuildContext context, index) {
        return  isShimmer?GridTitleShimmerWidget():GridTitleWidget(

          rating: movies[index].rating,
          id: movies[index].id,
          image: movies[index].image,
          productionData: movies[index].productionData,
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
