import 'package:ditonton/domain/entities/genre_tv.dart';
import 'package:equatable/equatable.dart';

class Tvgnremdl extends Equatable {
  Tvgnremdl({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Tvgnremdl.fromJson(Map<String, dynamic> json) => Tvgnremdl(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  Genretv toEntity() {
    return Genretv(id: this.id, name: this.name);
  }

  @override
  List<Object?> get props => [id, name];
}
