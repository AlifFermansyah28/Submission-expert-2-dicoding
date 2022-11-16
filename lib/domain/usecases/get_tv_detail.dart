import 'package:ditonton/domain/repositories/tv_repo.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
class GetTvDetail {
  final TvRepo repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDet>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
