import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/favorite/favorite_cubit.dart';
import '../../business_logic/cubit/favorite/favorite_state.dart';
import '../../constants/color_manager.dart';
import '../../data/models/movie.dart';

class IconFavoriteButtonWidget extends StatelessWidget {
  IconFavoriteButtonWidget({Key? key,
    this.returnFavorite,
    required this.movieHive,
    required this.paddingSize,
    required this.size})
      : super(key: key);
  final Movie movieHive;
  final double size;
  final double paddingSize;
  bool isFavorite = false;
  Function(bool)? returnFavorite;

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<FavoriteCubit, FavoriteState>(builder: (context, state) {
      isFavorite = BlocProvider.of<FavoriteCubit>(context)
          .isMovieFavorite(movieHive.id!);
      return IconButton(
        constraints: const BoxConstraints(),
        onPressed: () {
          isFavorite
              ? BlocProvider.of<FavoriteCubit>(context)
              .removeMovieFavorite(movieHive)
              : BlocProvider.of<FavoriteCubit>(context)
              .addMovieFavorite(movieHive);

          isFavorite = !isFavorite;
          returnFavorite?.call(isFavorite);
        },
        padding: EdgeInsets.all(paddingSize),
        icon: Icon(
            size: size, isFavorite ? Icons.favorite : Icons.favorite_border),
        color: ColorManager.red,
      );
    });
  }
}
