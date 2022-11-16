import 'package:ditonton/presentation/bloc/tv_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_tv_bloc_.dart';


void main() {
  late TopRatedTvSeriesBlocHelper topRatedTvBlocHelper;

  setUpAll(() {
    topRatedTvBlocHelper = TopRatedTvSeriesBlocHelper();
    registerFallbackValue(TopRatedTvSeriesEventBlocHelper());
    registerFallbackValue(TopRatedTvSeriesStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvSeriesBloc>(
      create: (_) => topRatedTvBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
          (WidgetTester tester) async {
        when(() => topRatedTvBlocHelper.state).thenReturn(TvSeriesLoading());

        final progressFinder = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display when data is loaded',
          (WidgetTester tester) async {
        when(() => topRatedTvBlocHelper.state)
            .thenAnswer((invocation) => TvSeriesLoading());
        when(() => topRatedTvBlocHelper.state).thenReturn(TvSeriesHasData(testTvList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

        expect(listViewFinder, findsOneWidget);
      });

}
