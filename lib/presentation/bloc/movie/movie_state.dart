part of 'movie_bloc.dart';

abstract class MovieStateBloc extends Equatable {
  const MovieStateBloc();
  
  @override
  List<Object> get props => [];
}

class MoviesLoading extends MovieStateBloc {}

class MoviesEmpty extends MovieStateBloc {}

class MoviesHasData extends MovieStateBloc {
  final List<Movie> movie;

  const MoviesHasData(this.movie);

  @override
  List<Object> get props => [movie];
}

class MoviesError extends MovieStateBloc {
  final String message;

  const MoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailState extends MovieStateBloc{
  final MovieDetail movie;

  MovieDetailState(this.movie);

  @override
  List<Object> get props => [movie];
}

class WatchlistMovieState extends MovieStateBloc{
  final List<Movie> movies;

  WatchlistMovieState(this.movies);

  @override
  List<Object> get props => [movies];
}

class WatchlistMovieMessage extends MovieStateBloc{
  final String message;
  const WatchlistMovieMessage(this.message);
  @override
  List<Object> get props => [message];
}

class WatchlistMovieStatusState extends MovieStateBloc {
  final bool status;

  const WatchlistMovieStatusState(this.status);

  @override
  List<Object> get props => [status];
}

// SEARCH MOVIE
class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends SearchState {
  final List<Movie> result;

  SearchHasData(this.result);

  @override
  List<Object> get props => [result];

}

class MovieDetailDataState extends SearchState{
  final MovieDetail movie;

  MovieDetailDataState(this.movie);

  @override
  List<Object> get props => [movie];
}