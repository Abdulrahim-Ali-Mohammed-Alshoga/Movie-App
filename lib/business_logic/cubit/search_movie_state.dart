abstract class SearchMovieState{}
class SearchMovieInitialState extends SearchMovieState{}
class SearchMovieLoading extends SearchMovieState{}
class SearchMovieSuccess extends SearchMovieState{}
class SearchMovieFailure extends SearchMovieState{}
class SearchNotConnected extends SearchMovieState{}