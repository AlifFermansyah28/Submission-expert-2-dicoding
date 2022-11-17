import 'package:ditonton/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_movies_bloc.dart';

void main() {
  late MovieDetailBlocHelper movieDetailBlocHelper;
  late RecommendationsMovieBlocHelper recommendationsMovieBlocHelper;
  late WatchlistMovieBlocHelper watchlistMovieBlocHelper;

  setUpAll(() {
    movieDetailBlocHelper = MovieDetailBlocHelper();
    registerFallbackValue(MovieDetailEventHelper());
    registerFallbackValue(MovieDetailStateHelper());

    recommendationsMovieBlocHelper = RecommendationsMovieBlocHelper();
    registerFallbackValue(RecommendationsMovieEventHelper());
    registerFallbackValue(RecommendationsMovieStateHelper());

    watchlistMovieBlocHelper = WatchlistMovieBlocHelper();
    registerFallbackValue(WatchlistMovieEventHelper());
    registerFallbackValue(WatchlistMovieStateHelper());

  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(create: (_) => movieDetailBlocHelper),
        BlocProvider<WatchlistBloc>(
          create: (_) => watchlistMovieBlocHelper,
        ),
        BlocProvider<MovieRecommendationBloc>(
          create: (_) => recommendationsMovieBlocHelper,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => movieDetailBlocHelper.state).thenReturn(MoviesLoading());
        when(() => watchlistMovieBlocHelper.state).thenReturn(MoviesLoading());
        when(() => recommendationsMovieBlocHelper.state)
            .thenReturn(MoviesLoading());

        final circularProgress = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
          id: 1,
        )));
        await tester.pump();

        expect(circularProgress, findsOneWidget);
      });
  testWidgets(
      'Watchlist button should display + icon when movie not added to watch list',
          (WidgetTester tester) async {
        when(() => movieDetailBlocHelper.state)
            .thenReturn(MovieDetailState(testMovieDetail));
        when(() => recommendationsMovieBlocHelper.state)
            .thenReturn(MoviesHasData(testMovieList));
        when(() => watchlistMovieBlocHelper.state)
            .thenReturn(WatchlistMovieStatusState(false));

        final watchListButtonIcon = find.byIcon(Icons.add);

        await tester
            .pumpWidget(_makeTestableWidget( MovieDetailPage(id: 97080)));
        await tester.pump();
        expect(watchListButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display check icon when movie added to watch list',
          (WidgetTester tester) async {
        when(() => movieDetailBlocHelper.state)
            .thenReturn(MovieDetailState(testMovieDetail));

        when(() => recommendationsMovieBlocHelper.state)
            .thenReturn(MoviesHasData(testMovieList));
        when(() => watchlistMovieBlocHelper.state)
            .thenReturn(WatchlistMovieStatusState(true));

        final watchListButtonIcon = find.byIcon(Icons.check);

        await tester
            .pumpWidget(_makeTestableWidget( MovieDetailPage(id: 97080)));
        expect(watchListButtonIcon, findsOneWidget);
      });
}
