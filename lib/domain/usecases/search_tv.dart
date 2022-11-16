import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
class SearchTv {
  final TvRepo repository;

  SearchTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTv(query);
  }
}
