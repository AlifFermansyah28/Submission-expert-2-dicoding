import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie/movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class NowPlayingMoviesEventHelper extends Fake implements MovieEventBloc {}

class NowPlayingMoviesStateHelper extends Fake implements MovieStateBloc {}

class NowPlayingMoviesBlocHelper
    extends MockBloc<MovieEventBloc, MovieStateBloc>
    implements NowPlayingMovieBloc {}

class PopularMoviesEventHelper extends Fake implements MovieEventBloc {}

class PopularMoviesStateHelper extends Fake implements MovieStateBloc {}

class PopularMoviesBlocHelper extends MockBloc<MovieEventBloc, MovieStateBloc>
    implements PopularMovieBloc {}

class TopRatedMoviesEventHelper extends Fake implements MovieEventBloc {}

class TopRatedMoviesStateHelper extends Fake implements MovieStateBloc {}

class TopRatedMoviesBlocHelper extends MockBloc<MovieEventBloc, MovieStateBloc>
    implements TopRatedMovieBloc {}

class MovieDetailEventHelper extends Fake implements MovieEventBloc {}

class MovieDetailStateHelper extends Fake implements MovieStateBloc {}

class MovieDetailBlocHelper extends MockBloc<MovieEventBloc, MovieStateBloc>
    implements MovieDetailBloc {}

class RecommendationsMovieEventHelper extends Fake implements MovieEventBloc {}

class RecommendationsMovieStateHelper extends Fake implements MovieStateBloc {}

class RecommendationsMovieBlocHelper
    extends MockBloc<MovieEventBloc, MovieStateBloc>
    implements MovieRecommendationBloc {}

class WatchlistMovieEventHelper extends Fake implements MovieEventBloc {}

class WatchlistMovieStateHelper extends Fake implements MovieStateBloc {}

class WatchlistMovieBlocHelper extends MockBloc<MovieEventBloc, MovieStateBloc>
    implements WatchlistBloc {}
