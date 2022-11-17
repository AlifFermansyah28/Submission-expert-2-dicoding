import 'package:ditonton/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:mocktail/mocktail.dart';


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_movies_bloc.dart';

void main() {
  late PopularMoviesBlocHelper popularMoviesBlocHelper;
  setUpAll(() {
    popularMoviesBlocHelper = PopularMoviesBlocHelper();
    registerFallbackValue(PopularMoviesStateHelper());
    registerFallbackValue(PopularMoviesEventHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>(
      create: (_) => popularMoviesBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    popularMoviesBlocHelper.close();
  });

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => popularMoviesBlocHelper.state).thenReturn(MoviesLoading());

        final progressBarFinder = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        when(() => popularMoviesBlocHelper.state).thenReturn(MoviesLoading());
        when(() => popularMoviesBlocHelper.state)
            .thenReturn(MoviesHasData(testMovieList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

        expect(listViewFinder, findsOneWidget);
      });

 
}
