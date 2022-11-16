import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

abstract class TvRepo {
  Future<Either<Failure, List<Tv>>> getOnAirTv();
  Future<Either<Failure, TvDet>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendations(id);
  Future<Either<Failure, List<Tv>>> getPopularTv();
  Future<Either<Failure, List<Tv>>> getTopRatedTv();
  Future<Either<Failure, List<Tv>>> searchTv(String query);
  Future<Either<Failure, String>> saveWatchlist(TvDet tv);
  Future<Either<Failure, String>> removeWatchlist(TvDet tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTv();
}


