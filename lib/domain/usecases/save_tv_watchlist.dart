import 'package:ditonton/domain/repositories/tv_repo.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

class SaveTvWatchlist {
  final TvRepo repository;

  SaveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDet tv) {
    return repository.saveWatchlist(tv);
  }
}
