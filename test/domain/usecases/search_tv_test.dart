import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTv usecase;
  late MockTvRepo mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepo();
    usecase = SearchTv(mockTvRepository);
  });

  final tTvSearch = <Tv>[];
  final tQuery = 'Spiderman';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTvRepository.searchTv(tQuery))
        .thenAnswer((_) async => Right(tTvSearch));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvSearch));
  });
}
