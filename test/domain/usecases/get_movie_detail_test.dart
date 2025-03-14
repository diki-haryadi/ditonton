import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'get_movie_detail_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MockGetMovieDetail usecase;

  setUp(() {
    usecase = MockGetMovieDetail();
  });

  final tId = 1;

  test('should get movie detail from the repository', () async {
    // arrange
    when(usecase.execute(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testMovieDetail));
  });
}