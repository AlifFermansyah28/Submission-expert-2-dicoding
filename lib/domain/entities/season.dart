import 'package:equatable/equatable.dart';

class Season extends Equatable {
  const Season({
    required this.id,
    required this.name,
    required this.episodeCount,
    required this.posterPath,
  });

  final int id;
  final String name;
  final int episodeCount;
  final String? posterPath;

  @override
  List<Object?> get props => [
        id,
        name,
        episodeCount,
        posterPath,
      ];
}
