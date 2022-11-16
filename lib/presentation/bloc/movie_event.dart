part of 'movie_bloc.dart';

abstract class MovieEventBloc extends Equatable {
  const MovieEventBloc();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingMovies extends MovieEventBloc{}
class FetchPopularMovies extends MovieEventBloc{}
class FetchTopRatedMovies extends MovieEventBloc{}
class FetchWatchlistMovies extends MovieEventBloc {}


class FetchDetailMovie extends MovieEventBloc{
  final int id;
  
  FetchDetailMovie(this.id);

  @override
  List<Object> get props => [id];
}
class FetchMovieRecommendation extends MovieEventBloc {
  final int id;
  const FetchMovieRecommendation(this.id);

  @override
  List<Object> get props => [id];
}

class SaveWatchistMovie extends MovieEventBloc {
  final MovieDetail movie;

  const SaveWatchistMovie(this.movie);
  @override
  List<Object> get props => [movie];

  execute(MovieDetail movie) {}
}

class RemoveWatchlistMovie extends MovieEventBloc {
  final MovieDetail movie;

  const RemoveWatchlistMovie(this.movie);
  @override
  List<Object> get props => [movie];

  execute(MovieDetail movie) {}
}

class WatchlistMovieStatus extends MovieEventBloc {
  final int id;

  const WatchlistMovieStatus(this.id);

  @override
  List<Object> get props => [id];
}

// SEARCH MOVIE
class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends SearchEvent{
  final String query;

  OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

