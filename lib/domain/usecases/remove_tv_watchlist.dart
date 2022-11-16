import 'package:ditonton/domain/repositories/tv_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
class RemoveTvWatchlist {
  final TvRepo repository;

  RemoveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDet tv) {
    return repository.removeWatchlist(tv);
  }
}
