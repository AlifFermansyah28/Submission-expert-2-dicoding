import 'package:ditonton/common/koneksi.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/db/tv_db.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repo.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  TvRepo,
  MovieRemoteDataSource,
  TvRemoteDataSource,
  MovieLocalDataSource,
  TvLclSrc,
  DatabaseHelper,
  TvDb,
  Koneksi,
], customMocks: [
  MockSpec<IOClient>(as: #MockHttpClient)
])
void main() {}