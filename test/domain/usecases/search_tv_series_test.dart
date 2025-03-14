import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_series_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SearchTvSeries(mockTvSeriesRepository);
  });

  final tQuery = 'Game of Thrones';

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.searchTvSeries(tQuery))
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(testTvSeriesList));
    verify(mockTvSeriesRepository.searchTvSeries(tQuery));
    verifyNoMoreInteractions(mockTvSeriesRepository);
  });
}
