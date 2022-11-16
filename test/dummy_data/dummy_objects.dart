import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_tbl.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/genre_tv.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testMovie = Movie(
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

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};


final testTv = Tv(
  backdropPath: '/i9htchhoOl26cLaslVHXHghgLt0.jpg',
  genreIds: [10759, 16,10762],
  id: 65334,
  originalName: 'Miraculous, les aventures de Ladybug et Chat Noir',
  overview:
      'Normal high school kids by day, protectors of Paris by night! Miraculous follows the heroic adventures of Marinette and Adrien as they transform into Ladybug and Cat Noir and set out to capture akumas, creatures responsible for turning the people of Paris into villains. But neither hero knows the others true identity   or that they re classmates!',
  popularity: 2592.78,
  posterPath: '/psDcRgUX38cIeGeADwLRPyO7SYC.jpg',
  firstAirDate: '2015-10-19',
  name: 'Miraculous: Tales of Ladybug & Cat Noir',
  voteAverage: 8,
  voteCount: 3840,
);

final testTvList = [testTv];

final testTvDetail = TvDet(
  backdropPath: 'backdropPath',
  genres: [Genretv(id: 1, name: 'Action')],
  seasons: [
    Season(id: 1, name: 'Season 1', episodeCount: 1, posterPath: 'posterPath'),
  ],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  name: 'name',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: null,
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = Tvku(
  id: 1,
  name: null,
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
