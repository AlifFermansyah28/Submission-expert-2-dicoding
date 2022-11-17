import 'package:ditonton/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_movies_bloc.dart';

void main() {
  late TopRatedMoviesBlocHelper topRatedMoviesBlocHelper;

  setUpAll(() {
    topRatedMoviesBlocHelper = TopRatedMoviesBlocHelper();
    registerFallbackValue(TopRatedMoviesBlocHelper());
    registerFallbackValue(TopRatedMoviesStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMovieBloc>(
      create: (_) => topRatedMoviesBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
          (WidgetTester tester) async {
        when(() => topRatedMoviesBlocHelper.state).thenReturn(MoviesLoading());

        final progressFinder = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display when data is loaded',
          (WidgetTester tester) async {
        when(() => topRatedMoviesBlocHelper.state)
            .thenAnswer((invocation) => MoviesLoading());
        when(() => topRatedMoviesBlocHelper.state)
            .thenReturn(MoviesHasData(testMovieList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

        expect(listViewFinder, findsOneWidget);
      });

 
}
