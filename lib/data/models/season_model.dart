import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  const SeasonModel({
    required this.id,
    required this.name,
    required this.episodeCount,
    required this.posterPath,
  });

  final int id;
  final String name;
  final int episodeCount;
  final String? posterPath;

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        id: json["id"],
        name: json["name"],
        episodeCount: json["episode_count"],
        posterPath: json["poster_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  Season toEntity() {
    return Season(
      id: id,
      name: name,
      episodeCount: episodeCount,
      posterPath: posterPath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        episodeCount,
        posterPath,
      ];
}
