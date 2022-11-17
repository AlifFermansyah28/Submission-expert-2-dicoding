part of 'tv_bloc.dart';

abstract class TvSeriesEventBloc extends Equatable {
  const TvSeriesEventBloc();

  @override
  List<Object> get props => [];
}


class FetchNowPlayingTvSeries extends TvSeriesEventBloc{}
class FetchPopularTvSeries extends TvSeriesEventBloc{}
class FetchTopRatedTvSeries extends TvSeriesEventBloc{}
class FetchWatchlistTvSeries extends TvSeriesEventBloc {}


class FetchDetailTvSeries extends TvSeriesEventBloc{
  final int id;
  
  FetchDetailTvSeries(this.id);

  @override
  List<Object> get props => [id];
}
class FetchTvSeriesRecommendation extends TvSeriesEventBloc {
  final int id;
  const FetchTvSeriesRecommendation(this.id);

  @override
  List<Object> get props => [id];
}

class SaveWatchistTvSeriesEvent extends TvSeriesEventBloc {
  final TvDet tvSeries;

  const SaveWatchistTvSeriesEvent(this.tvSeries);
  @override
  List<Object> get props => [tvSeries];
}

class RemoveWatchlistTvSeriesEvent extends TvSeriesEventBloc {
  final TvDet tvSeries;

  const RemoveWatchlistTvSeriesEvent(this.tvSeries);
  @override
  List<Object> get props => [tvSeries];
}

class WatchlistTvSeriesStatus extends TvSeriesEventBloc {
  final int id;

  const WatchlistTvSeriesStatus(this.id);

  @override
  List<Object> get props => [id];
}

// SEARCH TV SERIES
class SearchEventTvSeries extends Equatable {
  const SearchEventTvSeries();

  @override
  List<Object> get props => [];
}

class OnQueryChangedTvSeries extends SearchEventTvSeries{
  final String query;

  OnQueryChangedTvSeries(this.query);

  @override
  List<Object> get props => [query];
}


