import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart'; 
import 'package:ditonton/data/models/tv_tbl.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repo.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';

class TvRepoImpl implements TvRepo {
  final TvRemoteDataSource remoteDataSource;
  final TvLclSrc localDataSource;

  TvRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Tv>>> getPopularTv() async {
    try {
      final result = await remoteDataSource.getPopularTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan'));
    } on TlsException{
      return left(SSLFailure('Certificate gagal terverifikasi'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTv() async {
    try {
      final result = await remoteDataSource.getTopRatedTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan'));
    } on TlsException{
      return left(SSLFailure('Certificate gagal terverifikasi'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getOnAirTv() async {
    try {
      final result = await remoteDataSource.getOnAiringTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan'));
    } on TlsException{
      return left(SSLFailure('Certificate gagal terverifikasi'));
    }
  }

  @override
  Future<Either<Failure, TvDet>> getTvDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan'));
    } on TlsException{
      return left(SSLFailure('Certificate gagal terverifikasi'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvRecommendations(id) async {
    try {
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan'));
    } on TlsException{
      return left(SSLFailure('Certificate gagal terverifikasi'));
    }
  }



  @override
  Future<Either<Failure, List<Tv>>> searchTv(String query) async {
    try {
      final result = await remoteDataSource.searchTv(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Gagal terhubung ke jaringan'));
    } on TlsException{
      return left(SSLFailure('Certificate gagal terverifikasi'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvDet tv) async {
    try {
      final result =
          await localDataSource.insertWatchlist(Tvku.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    } 
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(TvDet movie) async {
    try {
      final result =
          await localDataSource.removeWatchlist(Tvku.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchlistTv() async {
    final result = await localDataSource.getWatchlistTv();
    return Right(result.map((data) => data.toEntity()).toList());
  }
  
  
  }

