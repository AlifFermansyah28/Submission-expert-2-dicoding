import 'package:ditonton/domain/repositories/tv_repo.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
class GetTvRecommendations {
  final TvRepo repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
