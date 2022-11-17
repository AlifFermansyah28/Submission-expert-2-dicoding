import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv/tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class NowPlayingTvSeriesHelper extends Fake implements TvSeriesEventBloc {}

class NowPlayingTvSeriesStateHelper extends Fake implements TvSeriesStateBloc {}

class NowPlayingTvSeriesBlocHelper extends MockBloc<TvSeriesEventBloc, TvSeriesStateBloc>
    implements NowPlayingTvSeriesBloc {}

class PopularTvSeriesEventBlocHelper extends Fake implements TvSeriesEventBloc {}

class PopularTvSeriesStateHelper extends Fake implements TvSeriesStateBloc {}

class PopularTvSeriesBlocHelper extends MockBloc<TvSeriesEventBloc, TvSeriesStateBloc>
    implements PopularTvSeriesBloc {}

class TopRatedTvSeriesEventBlocHelper extends Fake implements TvSeriesEventBloc {}

class TopRatedTvSeriesStateHelper extends Fake implements TvSeriesStateBloc {}

class TopRatedTvSeriesBlocHelper extends MockBloc<TvSeriesEventBloc, TvSeriesStateBloc>
    implements TopRatedTvSeriesBloc {}

class TvSeriesDetailEventHelper extends Fake implements TvSeriesEventBloc {}

class TvSeriesDetailStateHelper extends Fake implements TvSeriesStateBloc {}

class TvSeriesDetailBlocHelper extends MockBloc<TvSeriesEventBloc, TvSeriesStateBloc>
    implements TvSeriesDetailBloc {}

class TvSeriesRecommendationEventBlocHelper extends Fake implements TvSeriesEventBloc {}

class TvSeriesRecommendationStateHelper extends Fake implements TvSeriesStateBloc {}

class TvSeriesRecommendationBlocHelper extends MockBloc<TvSeriesEventBloc, TvSeriesStateBloc>
    implements TvSeriesRecommendationBloc {}

class WatchlistTvSeriesEventBlocHelper extends Fake implements TvSeriesEventBloc {}

class WatchlistTvSeriesStateHelper extends Fake implements TvSeriesStateBloc {}

class WatchlistTvSeriesBlocHelper extends MockBloc<TvSeriesEventBloc, TvSeriesStateBloc>
    implements WatchlistTvSeriesBloc {}
