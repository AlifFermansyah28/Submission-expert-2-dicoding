import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTv usecase;
  late MockTvRepo mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepo();
    usecase = GetTopRatedTv(mockTvRepository);
  });

  final tTvTopRated = <Tv>[];

  test('should get list of movies from repository', () async {
    // arrange
    when(mockTvRepository.getTopRatedTv())
        .thenAnswer((_) async => Right(tTvTopRated));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvTopRated));
  });
}
