import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/movie_details.dart';
import '../../../data/network/network_information.dart';
import '../../../data/repository/movie_details_repository.dart';
import 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState>{
  MovieDetailsCubit(this.movieDetailsRepository,this.networkInformation):super(MovieDetailsInitialState());
  MovieDetailsRepository movieDetailsRepository;
  NetworkInfo networkInformation;
  MovieDetails? movieDetails;


  getMovieDetails({required int idMovie})async {
    if (await networkInformation.isConnected) {

        emit(MovieDetailsLoading());

      try {

        movieDetails=await movieDetailsRepository.getMovieDetails(idMovie);

        emit(MovieDetailsSuccess());
      } catch (e) {
        print(e);
        emit(MovieDetailsFailure());
      }
    } else {
        emit(MovieDetailsNotConnected());
    }
  }
}