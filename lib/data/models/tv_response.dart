import 'package:ditonton/data/models/tv_model.dart';
import 'package:equatable/equatable.dart';

class TvRspn extends Equatable {
  final List<Tvmdl> tvList;

  TvRspn({required this.tvList});

  factory TvRspn.fromJson(Map<String, dynamic> json) => TvRspn(
        tvList: List<Tvmdl>.from((json["results"] as List)
            .map((x) => Tvmdl.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [tvList];
}
