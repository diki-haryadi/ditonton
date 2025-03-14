import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getWatchlistTvSeries())
        .thenAnswer((_) async => Right([testWatchlistTvSeries]));
    // act
    final result = await usecase.execute();
    // assert
    expect(result.isRight(), true);
    expect((result as Right).value, [testWatchlistTvSeries]);
    verify(mockTvSeriesRepository.getWatchlistTvSeries());
    verifyNoMoreInteractions(mockTvSeriesRepository);
  });
}
