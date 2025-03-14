import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_movie_recommendations_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations usecase;

  setUp(() {
    usecase = MockGetMovieRecommendations();
  });

  final tId = 1;
  final tMovies = <Movie>[];

  test('should get list of movie recommendations from the repository',
      () async {
    // arrange
    when(usecase.execute(tId)).thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tMovies));
  });
}