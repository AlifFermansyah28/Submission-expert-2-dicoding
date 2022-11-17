import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
part 'movie_event.dart';
part 'movie_state.dart';

/// NOW PLAYING MOVIE
class NowPlayingMovieBloc extends Bloc<MovieEventBloc, MovieStateBloc>{
  final GetNowPlayingMovies _getNowPlayingMovie;

  NowPlayingMovieBloc(this._getNowPlayingMovie) : super(MoviesLoading()){
    on<FetchNowPlayingMovies>((event, emit) async {
      
      emit(MoviesLoading());
      final result = await _getNowPlayingMovie.execute();
      result.fold(
        (failure){
        emit(MoviesError(failure.message));
        }, 
        (data) {
          emit(MoviesHasData(data));
        });
    });
  }
}

/// POPULAR MOVIE
class PopularMovieBloc extends Bloc<MovieEventBloc, MovieStateBloc>{
  final GetPopularMovies _getPopularMovies;

  PopularMovieBloc(this._getPopularMovies) : super(MoviesLoading()){
    on<FetchPopularMovies>((event, emit) async {
      
      emit(MoviesLoading());
      final result = await _getPopularMovies.execute();
      result.fold(
        (failure){
        emit(MoviesError(failure.message));
        }, 
        (data) {
          emit(MoviesHasData(data));
        });
    });
  }
}

/// TOP RATED
class TopRatedMovieBloc extends Bloc<MovieEventBloc, MovieStateBloc>{
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMovieBloc(this._getTopRatedMovies) : super(MoviesLoading()){
    on<FetchTopRatedMovies>((event, emit) async {
      
      emit(MoviesLoading());
      final result = await _getTopRatedMovies.execute();
      result.fold(
        (failure){
        emit(MoviesError(failure.message));
        }, 
        (data) {
          emit(MoviesHasData(data));
        });
    });
  }
}

/// MOVIE DETAIL
class MovieDetailBloc extends Bloc<MovieEventBloc, MovieStateBloc> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(MoviesLoading()) {
    on<FetchDetailMovie>((event, emit) async {
      final id = event.id;

      emit(MoviesLoading());

      final result = await _getMovieDetail.execute(id);
      result.fold(
        (failure) {
        emit(MoviesError(failure.message));
      }, (data) {
        emit(MovieDetailState(data));
      });
    });
  }
}

class MovieRecommendationBloc extends Bloc<MovieEventBloc, MovieStateBloc>{
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendationBloc(this._getMovieRecommendations) : super(MoviesLoading()){
    on<FetchMovieRecommendation>((event, emit) async {
      
      final int id = event.id;
      emit(MoviesLoading());

      final result = await _getMovieRecommendations.execute(id);
      result.fold(
        (failure){
        emit(MoviesError(failure.message));
        }, 
        (data) {
          emit(MoviesHasData(data));
        });
    });
  }
}


class WatchlistBloc extends Bloc<MovieEventBloc, MovieStateBloc> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistBloc(this._getWatchlistMovies, this._getWatchListStatus,
      this._saveWatchlist, this._removeWatchlist)
      : super(MoviesEmpty()) {
    on<FetchWatchlistMovies>(
          (event, emit) async {
        emit(MoviesLoading());

        final result = await _getWatchlistMovies.execute();
        result.fold((failure) {
          emit(
            MoviesError(failure.message));
        }, (data) {
          emit(WatchlistMovieState(data));
        });
      },
    );

    on<SaveWatchistMovie>((event, emit) async {
      final movie = event.movie;
      emit(MoviesLoading());
      final result = await _saveWatchlist.execute(movie);

      result.fold((failure) => emit(MoviesError(failure.message)),
              (data) => emit(WatchlistMovieMessage(data)));
    });

    on<RemoveWatchlistMovie>((event, emit) async {
      final movie = event.movie;
      emit(MoviesLoading());
      final result = await _removeWatchlist.execute(movie);

      result.fold((failure) => emit(MoviesError(failure.message)),
              (data) => emit(WatchlistMovieMessage(data)));
    });

    on<WatchlistMovieStatus>((event, emit) async {
      final id = event.id;
      emit(MoviesLoading());
      final result = await _getWatchListStatus.execute(id);

      emit(WatchlistMovieStatusState(result));
    });
  }
}

/// SEARCH MOVIE
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;

  SearchBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());

      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
