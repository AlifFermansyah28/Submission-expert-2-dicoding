import 'package:bloc_test/bloc_test.dart';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


import 'movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetNowPlayingMovies,
  GetTopRatedMovies,
  GetPopularMovies,
  GetWatchlistMovies,
  GetWatchListStatus,
  RemoveWatchlist,
  SaveWatchlist,
  SearchMovies
])
void main() {
  late NowPlayingMovieBloc nowPlayingMoviesBloc;
  late PopularMovieBloc popularMoviesBloc;
  late TopRatedMovieBloc topRatedMoviesBloc;
  late MovieDetailBloc detailMovieBloc;
  late MovieRecommendationBloc recommendationMovieBloc;
  late WatchlistBloc watchListBloc;
  late SearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;

  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockRemoveWatchlist mockRemoveWatchlistMovies;
  late MockSaveWatchlist mockSaveWatchistMovies;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockSaveWatchistMovies = MockSaveWatchlist();
    mockRemoveWatchlistMovies = MockRemoveWatchlist();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSearchMovies = MockSearchMovies();
    searchBloc = SearchBloc(mockSearchMovies);

    nowPlayingMoviesBloc = NowPlayingMovieBloc(mockGetNowPlayingMovies);
    popularMoviesBloc = PopularMovieBloc(mockGetPopularMovies);
    topRatedMoviesBloc = TopRatedMovieBloc(mockGetTopRatedMovies);
    recommendationMovieBloc =
        MovieRecommendationBloc(mockGetMovieRecommendations);
    detailMovieBloc = MovieDetailBloc(mockGetMovieDetail);
    watchListBloc = WatchlistBloc(
        mockGetWatchlistMovies,
        mockGetWatchListStatus,
        mockSaveWatchistMovies,
        mockRemoveWatchlistMovies);
  });
  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tQuery = "spiderman";
  final tMovieList = <Movie>[tMovie];

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
    genres: [Genre(id: 1, name: 'name')],
  );

  final tId = 1;

  group('Get now playing movies', () {
    test('initial state must be empty', () {
      expect(nowPlayingMoviesBloc.state, MoviesLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingMoviesBloc;
      },
      act: (NowPlayingMovieBloc bloc) => bloc.add(FetchNowPlayingMovies()),
      wait: Duration(milliseconds: 500),
      expect: () => [MoviesLoading(), MoviesHasData(tMovieList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return nowPlayingMoviesBloc;
      },
      act: (NowPlayingMovieBloc bloc) => bloc.add(FetchNowPlayingMovies()),
      wait: Duration(milliseconds: 500),
      expect: () => [
        MoviesLoading(),
        MoviesError('Server Failure'),
      ],
      verify: (NowPlayingMovieBloc bloc) =>
          verify(mockGetNowPlayingMovies.execute()),
    );
  });

  group('Get Popular movies', () {
    test('initial state must be empty', () {
      expect(popularMoviesBloc.state, MoviesLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularMoviesBloc;
      },
      act: (PopularMovieBloc bloc) => bloc.add(FetchPopularMovies()),
      wait: Duration(milliseconds: 500),
      expect: () => [MoviesLoading(), MoviesHasData(tMovieList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return popularMoviesBloc;
      },
      act: (PopularMovieBloc bloc) => bloc.add(FetchPopularMovies()),
      wait: Duration(milliseconds: 500),
      expect: () => [
        MoviesLoading(),
        const MoviesError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetPopularMovies.execute()),
    );
  });

  group('Get Top Rated movies', () {
    test('initial state must be empty', () {
      expect(topRatedMoviesBloc.state, MoviesLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedMoviesBloc;
      },
      act: (TopRatedMovieBloc bloc) => bloc.add(FetchTopRatedMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [MoviesLoading(), MoviesHasData(tMovieList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return topRatedMoviesBloc;
      },
      act: (TopRatedMovieBloc bloc) => bloc.add(FetchTopRatedMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MoviesLoading(),
        const MoviesError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTopRatedMovies.execute()),
    );
  });

  group('Get Recommended movies', () {
    test('initial state must be empty', () {
      expect(recommendationMovieBloc.state, MoviesLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovieList));
        return recommendationMovieBloc;
      },
      act: (MovieRecommendationBloc bloc) =>
          bloc.add(FetchMovieRecommendation(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [MoviesLoading(), MoviesHasData(tMovieList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return recommendationMovieBloc;
      },
      act: (MovieRecommendationBloc bloc) =>
          bloc.add(FetchMovieRecommendation(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MoviesLoading(),
        const MoviesError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetMovieRecommendations.execute(tId)),
    );
  });

  group('Get Details movies', () {
    test('initial state must be empty', () {
      expect(detailMovieBloc.state, MoviesLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(tMovieDetail));
        return detailMovieBloc;
      },
      act: (MovieDetailBloc bloc) => bloc.add(FetchDetailMovie(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [MoviesLoading(), MovieDetailState(tMovieDetail)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return detailMovieBloc;
      },
      act: (MovieDetailBloc bloc) => bloc.add(FetchDetailMovie(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MoviesLoading(),
        const MoviesError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetMovieDetail.execute(tId)),
    );
  });

  group('Get Watchlist movies', () {
    test('initial state must be empty', () {
      expect(watchListBloc.state, MoviesEmpty());
    });

    group('Watchlist Movie', () {
      test('initial state should be empty', () {
        expect(watchListBloc.state, MoviesEmpty());
      });

      group('Fetch Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockGetWatchlistMovies.execute())
                .thenAnswer((_) async => Right(tMovieList));
            return watchListBloc;
          },
          act: (WatchlistBloc bloc) => bloc.add(FetchWatchlistMovies()),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            MoviesLoading(),
            WatchlistMovieState(tMovieList),
          ],
          verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockGetWatchlistMovies.execute())
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            return watchListBloc;
          },
          act: (WatchlistBloc bloc) => bloc.add(FetchWatchlistMovies()),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            MoviesLoading(),
            const MoviesError('Server Failure'),
          ],
          verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
        );
      });

      group('Load Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockGetWatchListStatus.execute(tId))
                .thenAnswer((_) async => true);
            return watchListBloc;
          },
          act: (WatchlistBloc bloc) => bloc.add(WatchlistMovieStatus(tId)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            MoviesLoading(),
            WatchlistMovieStatusState(true),
          ],
          verify: (bloc) => verify(mockGetWatchListStatus.execute(tId)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockGetWatchListStatus.execute(tId))
                .thenAnswer((_) async => false);
            return watchListBloc;
          },
          act: (WatchlistBloc bloc) => bloc.add(WatchlistMovieStatus(tId)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            MoviesLoading(),
            WatchlistMovieStatusState(false),
          ],
          verify: (bloc) => verify(mockGetWatchListStatus.execute(tId)),
        );
      });

      group('Save Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockSaveWatchistMovies.execute(tMovieDetail)).thenAnswer(
                (_) async => Right(WatchlistBloc.watchlistAddSuccessMessage));
            return watchListBloc;
          },
          act: (WatchlistBloc bloc) =>
              bloc.add(SaveWatchistMovie(tMovieDetail)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            MoviesLoading(),
            WatchlistMovieMessage(WatchlistBloc.watchlistAddSuccessMessage),
          ],
          verify: (bloc) =>
              verify(mockSaveWatchistMovies.execute(tMovieDetail)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockSaveWatchistMovies.execute(tMovieDetail))
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            return watchListBloc;
          },
          act: (WatchlistBloc bloc) =>
              bloc.add(SaveWatchistMovie(tMovieDetail)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            MoviesLoading(),
            MoviesError('Server Failure'),
          ],
          verify: (bloc) =>
              verify(mockSaveWatchistMovies.execute(tMovieDetail)),
        );
      });

      group('Remove Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockRemoveWatchlistMovies.execute(tMovieDetail)).thenAnswer(
                (_) async => Right(WatchlistBloc.watchlistAddSuccessMessage));
            return watchListBloc;
          },
          act: (WatchlistBloc bloc) =>
              bloc.add(RemoveWatchlistMovie(tMovieDetail)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            MoviesLoading(),
            WatchlistMovieMessage(WatchlistBloc.watchlistAddSuccessMessage),
          ],
          verify: (bloc) =>
              verify(mockRemoveWatchlistMovies.execute(tMovieDetail)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockRemoveWatchlistMovies.execute(tMovieDetail))
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            return watchListBloc;
          },
          act: (WatchlistBloc bloc) =>
              bloc.add(RemoveWatchlistMovie(tMovieDetail)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            MoviesLoading(),
            MoviesError('Server Failure'),
          ],
          verify: (bloc) =>
              verify(mockRemoveWatchlistMovies.execute(tMovieDetail)),
        );
      });

      group("search movie", () {
        test("initial state should be empty", () {
          expect(searchBloc.state, SearchEmpty());
        });

        blocTest<SearchBloc, SearchState>(
            "Should emit [Loading, HasData] when data is gotten successfully",
            build: () {
              when(mockSearchMovies.execute(tQuery))
                  .thenAnswer((_) async => Right(tMovieList));
              return searchBloc;
            },
            act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
            wait: const Duration(milliseconds: 500),
            expect: () => [SearchLoading(), SearchHasData(tMovieList)],
            verify: (bloc) {
              verify(mockSearchMovies.execute(tQuery));
            });
        blocTest<SearchBloc, SearchState>(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockSearchMovies.execute(tQuery))
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            return searchBloc;
          },
          act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            SearchLoading(),
            SearchError('Server Failure'),
          ],
          verify: (bloc) {
            verify(mockSearchMovies.execute(tQuery));
          },
        );
      });
    });
  });
}
