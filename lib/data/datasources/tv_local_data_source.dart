import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/tv_db.dart';
import 'package:ditonton/data/models/tv_tbl.dart';

abstract class TvLclSrc {
  Future<String> insertWatchlist(Tvku tv);
  Future<String> removeWatchlist(Tvku tv);
  Future<Tvku?> getTvById(int id);
  Future<List<Tvku>> getWatchlistTv();
}

class TvLclSrcImpl implements TvLclSrc {
  final TvDb databaseHelper;

 TvLclSrcImpl({required this.databaseHelper});

  @override
  Future<Tvku?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return Tvku.fromMap(result);
    } else {
      return null;
    }
  }
  @override
  Future<List<Tvku>> getWatchlistTv() async {
    final result = await databaseHelper.getWatchlistTv();
    return result.map((data) => Tvku.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlist(Tvku tv) async {
    try {
      await databaseHelper.insertWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
  @override
  Future<String> removeWatchlist(Tvku tv) async {
    try {
      await databaseHelper.removeWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  
}
