
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/network/network_information.dart';
import '../genre/genre_cubit.dart';
import '../now_playing_movies/now_playing_movies_cubit.dart';
import '../upcoming_movies/upcoming_movies_cubit.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.networkInformation) : super(HomeInitialState());
  NetworkInfo networkInformation;
  Future<void> getAllMovies(
      {required BuildContext context, required bool mounted}) async {


    if (await networkInformation.isConnected) {
      emit(HomeLoading());
      try {
        emit(HomeSuccess());
        BlocProvider.of<UpcomingMovieCubit>(context)
            .getAllMovies(numberPage: 1);
        BlocProvider.of<GenreCubit>(context).getAllGenre();
        BlocProvider.of<NowPlayingMovieCubit>(context)
            .getAllMovies(numberPage: 1);
      } catch (e) {
        print(e);
      }
    } else {
      emit(HomeNotConnected());
    }
  }
}
