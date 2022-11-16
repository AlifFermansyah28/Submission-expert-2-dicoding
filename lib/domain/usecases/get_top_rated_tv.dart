import 'package:ditonton/domain/repositories/tv_repo.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

class GetTopRatedTv {
  final TvRepo repository;

  GetTopRatedTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTv();
  }
}
