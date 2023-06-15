
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
  void getAllMovies (
      {required BuildContext context, required bool mounted})  async{


    if (await networkInformation.isConnected) {
      emit(HomeLoading());
      if (!mounted) return;
      try {
        emit(HomeSuccess());
         BlocProvider.of<UpcomingMovieCubit>(context)
            .getAllMovies();
         BlocProvider.of<GenreCubit>(context).getAllGenre();
         BlocProvider.of<NowPlayingMovieCubit>(context)
            .getAllMovies();
      } catch (e) {
        print(e);
      }
    } else {
      emit(HomeNotConnected());
    }
  }
  void checkTheNet()  {
print('objectlllllllllllp');
    emit(HomeFailure());
  }
}
