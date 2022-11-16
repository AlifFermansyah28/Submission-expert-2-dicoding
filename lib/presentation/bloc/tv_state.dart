part of 'tv_bloc.dart';

abstract class TvSeriesStateBloc extends Equatable {
  const TvSeriesStateBloc();
  
  @override
  List<Object> get props => [];
}

class TvSeriesLoading extends TvSeriesStateBloc {}

class TvSeriesEmpty extends TvSeriesStateBloc {}

class TvSeriesHasData extends TvSeriesStateBloc {
  final List<Tv> tvSeries;

  const TvSeriesHasData(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class TvSeriesError extends TvSeriesStateBloc {
  final String message;

  const TvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesDetailState extends TvSeriesStateBloc{
  final TvDet tvSeries;

  TvSeriesDetailState(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class WatchlistTvSeriesState extends TvSeriesStateBloc{
  final List<Tv> tvSeries;

  WatchlistTvSeriesState(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class WatchlistTvSeriesMessage extends TvSeriesStateBloc{
  final String message;
  const WatchlistTvSeriesMessage(this.message);
  @override
  List<Object> get props => [message];
}

class WatchlistTvSeriesStatusState extends TvSeriesStateBloc {
  final bool status;

  const WatchlistTvSeriesStatusState(this.status);

  @override
  List<Object> get props => [status];
}

// SEARCH MOVIE
class SearchStateTvSeries extends Equatable {
  const SearchStateTvSeries();
  
  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchStateTvSeries {}

class SearchLoading extends SearchStateTvSeries {}

class SearchError extends SearchStateTvSeries {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvSeriesHasData extends SearchStateTvSeries {
  final List<Tv> result;

  SearchTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];

}

class TvSeriesDetailDataState extends SearchStateTvSeries{
  final TvDet tvSeries;

  TvSeriesDetailDataState(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}