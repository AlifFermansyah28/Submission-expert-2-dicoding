import 'package:ditonton/domain/repositories/tv_repo.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
class GetOnAiringTv {
  final TvRepo repository;

  GetOnAiringTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getOnAirTv();
  }
}
