import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/tv.dart';

class Tvku extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  Tvku({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  
  @override
  List<Object?> get props => [id, name, posterPath, overview];

  factory Tvku.fromEntity(TvDet tv) => Tvku(
        id: tv.id,
        name: tv.name,
        posterPath: tv.posterPath,
        overview: tv.overview,
      );

  factory Tvku.fromMap(Map<String, dynamic> map) => Tvku(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };
  Tv toEntity() => Tv.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

}
