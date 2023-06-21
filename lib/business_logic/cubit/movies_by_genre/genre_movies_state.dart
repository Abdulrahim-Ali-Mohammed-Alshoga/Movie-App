abstract class GenreMoviesState{}
class GenreMoviesLoading extends GenreMoviesState{}
class GenreMoviesSuccess extends GenreMoviesState{}
class GenreMoviesFailure extends GenreMoviesState{
  GenreMoviesFailure({required this.isNoGenre});
   bool isNoGenre;
}
class GenreMoviesNotConnected extends GenreMoviesState{}