import 'package:ditonton/domain/repositories/tv_repo.dart';
class GetTvWatchListStatus {
  final TvRepo repository;

  GetTvWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
