import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:http/io_client.dart';

abstract class TvRemoteDataSource {
  Future<List<Tvmdl>> getOnAiringTv();
  Future<List<Tvmdl>> getPopularTv();
  Future<List<Tvmdl>> getTopRatedTv();
  Future<TvDtlRspn> getTvDetail(int id);
  Future<List<Tvmdl>> getTvRecommendations(int id);
  Future<List<Tvmdl>> searchTv(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  static const API_KEY = 'api_key=dd8945bc630a3cc7f43e2ff910cbebe7';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final IOClient client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Tvmdl>> getOnAiringTv() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));
    if (response.statusCode == 200) {
      return TvRspn.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

   @override
  Future<List<Tvmdl>> getTopRatedTv() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvRspn.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Tvmdl>> getPopularTv() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvRspn.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

 

  @override
  Future<TvDtlRspn> getTvDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvDtlRspn.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Tvmdl>> getTvRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvRspn.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Tvmdl>> searchTv(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));
    if (response.statusCode == 200) {
      return TvRspn.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
