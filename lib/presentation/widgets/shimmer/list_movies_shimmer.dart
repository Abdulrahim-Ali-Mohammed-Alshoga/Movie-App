// import 'package:flutter/material.dart';
// class ListMoviesShimmer extends StatelessWidget {
//   const ListMoviesShimmer({Key? key}) : super(key: key);
//
//
//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//           appBar: AppBar(
//             title: Text(widget.listMovies.genre.name,style: TextStyle(fontFamily:MyFont.titleFont ),),
//             centerTitle: true,
//           ),
//           body:BlocBuilder<MovieCubit, MovieState>(
//             builder: (context, state) {
//               if(state is MovieSuccess){
//                 movies = BlocProvider.of<MovieCubit>(context).movies;
//                 return   GridView.builder(
//                   shrinkWrap: true,
//                   controller: scrollController,
//                   physics: const ClampingScrollPhysics(),
//                   padding: EdgeInsets.zero,
//                   itemCount:movies.length,
//                   itemBuilder: (BuildContext context, index) {
//                     //  print(index);
// // if(index+1==movies.length){
// //
// //   isLoading=true;
// //   print(5555555555);
// // }
//                     return GridTitleWidget(movie:movies[index],);
//                   },
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio:.8,
//                       crossAxisSpacing: 1,
//                       mainAxisSpacing: 1),
//                 );
//               }
//               else{
//                 return Center(
//                   child: SizedBox(
//                     height: .1.h,
//                   ),
//                 );
//               }
//             },
//           )
//
//       );
//     }
//   };
//   }
// }
