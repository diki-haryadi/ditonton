import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_tv_series_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late MockSearchTvSeries usecase;

  setUp(() {
    usecase = MockSearchTvSeries();
  });

  final tTvSeries = <TvSeries>[];
  final tQuery = 'Game of Thrones';

  test('should get list of tv series from the repository', () async {
    // arrange
    when(usecase.execute(tQuery)).thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvSeries));
  });
}