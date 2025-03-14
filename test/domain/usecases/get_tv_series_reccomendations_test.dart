import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_tv_series_reccomendations_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late MockGetTvSeriesRecommendations usecase;

  setUp(() {
    usecase = MockGetTvSeriesRecommendations();
  });

  final tId = 1;
  final tTvSeries = <TvSeries>[];

  test('should get list of tv series recommendations from the repository',
      () async {
    // arrange
    when(usecase.execute(tId)).thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvSeries));
  });
}