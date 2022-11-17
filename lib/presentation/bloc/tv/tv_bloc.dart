import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recomendations.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_tv_on_airing.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
part 'tv_event.dart';
part 'tv_state.dart';

// NOW PLAYING TV SERIES
class NowPlayingTvSeriesBloc extends Bloc<TvSeriesEventBloc, TvSeriesStateBloc>{
  final GetOnAiringTv _getNowPlayingTvSeries;

  NowPlayingTvSeriesBloc(this._getNowPlayingTvSeries) : super(TvSeriesLoading()){
    on<FetchNowPlayingTvSeries>((event, emit) async {
      
      emit(TvSeriesLoading());
      final result = await _getNowPlayingTvSeries.execute();
      result.fold(
        (failure){
        emit(TvSeriesError(failure.message));
        }, 
        (data) {
          emit(TvSeriesHasData(data));
        });
    });
  }
}

// POPULAR TV SERIES
class PopularTvSeriesBloc extends Bloc<TvSeriesEventBloc, TvSeriesStateBloc>{
  final GetPopularTv _getPopularTvSeries;

  PopularTvSeriesBloc(this._getPopularTvSeries) : super(TvSeriesLoading()){
    on<FetchPopularTvSeries>((event, emit) async {
      
      emit(TvSeriesLoading());
      final result = await _getPopularTvSeries.execute();
      result.fold(
        (failure){
        emit(TvSeriesError(failure.message));
        }, 
        (data) {
          emit(TvSeriesHasData(data));
        });
    });
  }
}

// TOP RATED
class TopRatedTvSeriesBloc extends Bloc<TvSeriesEventBloc, TvSeriesStateBloc>{
  final GetTopRatedTv _getTopRatedTvSeries;

  TopRatedTvSeriesBloc(this._getTopRatedTvSeries) : super(TvSeriesLoading()){
    on<FetchTopRatedTvSeries>((event, emit) async {
      
      emit(TvSeriesLoading());
      final result = await _getTopRatedTvSeries.execute();
      result.fold(
        (failure){
        emit(TvSeriesError(failure.message));
        }, 
        (data) {
          emit(TvSeriesHasData(data));
        });
    });
  }
}

// TV SERIES DETAIL
class TvSeriesDetailBloc extends Bloc<TvSeriesEventBloc, TvSeriesStateBloc> {
  final GetTvDetail _getTvSeriesDetail;

  TvSeriesDetailBloc(this._getTvSeriesDetail) : super(TvSeriesLoading()) {
    on<FetchDetailTvSeries>((event, emit) async {
      final id = event.id;

      emit(TvSeriesLoading());

      final result = await _getTvSeriesDetail.execute(id);
      result.fold(
        (failure) {
        emit(TvSeriesError(failure.message));
      }, (data) {
        emit(TvSeriesDetailState(data));
      });
    });
  }
}

class TvSeriesRecommendationBloc extends Bloc<TvSeriesEventBloc, TvSeriesStateBloc>{
  final GetTvRecommendations _getTvSeriesRecommendations;

  TvSeriesRecommendationBloc(this._getTvSeriesRecommendations) : super(TvSeriesLoading()){
    on<FetchTvSeriesRecommendation>((event, emit) async {
      
      final int id = event.id;
      emit(TvSeriesLoading());

      final result = await _getTvSeriesRecommendations.execute(id);
      result.fold(
        (failure){
        emit(TvSeriesError(failure.message));
        }, 
        (data) {
          emit(TvSeriesHasData(data));
        });
    });
  }
}


class WatchlistTvSeriesBloc extends Bloc<TvSeriesEventBloc, TvSeriesStateBloc> {
  final GetWatchlistTv _getWatchlistTvSeries;
  final GetTvWatchListStatus _getWatchListStatusTvSeries;
  final SaveTvWatchlist _saveWatchlistTvSeries;
  final RemoveTvWatchlist _removeWatchlistTvSeries;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistTvSeriesBloc(this._getWatchlistTvSeries, this._getWatchListStatusTvSeries,
      this._saveWatchlistTvSeries, this._removeWatchlistTvSeries)
      : super(TvSeriesEmpty()) {
    on<FetchWatchlistTvSeries>(
          (event, emit) async {
        emit(TvSeriesLoading());

        final result = await _getWatchlistTvSeries.execute();
        result.fold((failure) {
          emit(
            TvSeriesError(failure.message));
        }, (data) {
          emit(WatchlistTvSeriesState(data));
        });
      },
    );

    on<SaveWatchistTvSeriesEvent>((event, emit) async {
      final tvSeries = event.tvSeries;
      emit(TvSeriesLoading());
      final result = await _saveWatchlistTvSeries.execute(tvSeries);

      result.fold((failure) => emit(TvSeriesError(failure.message)),
              (data) => emit(WatchlistTvSeriesMessage(data)));
    });

    on<RemoveWatchlistTvSeriesEvent>((event, emit) async {
      final tvSeries = event.tvSeries;
      emit(TvSeriesLoading());
      final result = await _removeWatchlistTvSeries.execute(tvSeries);

      result.fold((failure) => emit(TvSeriesError(failure.message)),
              (data) => emit(WatchlistTvSeriesMessage(data)));
    });

    on<WatchlistTvSeriesStatus>((event, emit) async {
      final id = event.id;
      emit(TvSeriesLoading());
      final result = await _getWatchListStatusTvSeries.execute(id);

      emit(WatchlistTvSeriesStatusState(result));
    });
  }
}

// SEARCH MOVIE
class SearchTvSeriesBloc extends Bloc<SearchEventTvSeries, SearchStateTvSeries> {
  final SearchTv _searchTvSeries;

  SearchTvSeriesBloc(this._searchTvSeries) : super(SearchEmpty()) {
    on<OnQueryChangedTvSeries>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());

      final result = await _searchTvSeries.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchTvSeriesHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

