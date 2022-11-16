import 'package:ditonton/domain/entities/genre_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/season.dart';

class TvDet extends Equatable {
  TvDet({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.voteAverage,
    required this.voteCount,
    required this.seasons,

  });

  final String? backdropPath;
  final List<Genretv> genres;
  final int id;
  final String originalName;
  final String overview;
  final String posterPath;
  final String firstAirDate;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final double voteAverage;
  final int voteCount;
  final List<Season> seasons;


  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        originalName,
        overview,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount,
        seasons,
      ];
}
