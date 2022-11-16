import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTv usecase;
  late MockTvRepo mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepo();
    usecase = GetPopularTv(mockTvRepository);
  });

  final tPopularTv = <Tv>[];

  group('GetPopularMovies Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRepository.getPopularTv())
            .thenAnswer((_) async => Right(tPopularTv));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tPopularTv));
      });
    });
  });
}
