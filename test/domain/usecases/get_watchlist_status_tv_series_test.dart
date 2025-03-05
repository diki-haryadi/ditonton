import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_watchlist_status_tv_series_test.mocks.dart';

@GenerateMocks([TvSeriesRepository])
void main() {
  late GetWatchListStatusTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetWatchListStatusTvSeries(mockTvSeriesRepository);
  });

  const tId = 1;

  group('GetWatchListStatusTvSeries', () {
    test('should get watchlist status from repository', () async {
      // arrange
      when(mockTvSeriesRepository.isAddedToWatchlist(tId))
          .thenAnswer((_) async => true);

      // act
      final result = await usecase.execute(tId);

      // assert
      expect(result, true);
      verify(mockTvSeriesRepository.isAddedToWatchlist(tId));
      verifyNoMoreInteractions(mockTvSeriesRepository);
    });

    test('should return false when tv series is not in watchlist', () async {
      // arrange
      when(mockTvSeriesRepository.isAddedToWatchlist(tId))
          .thenAnswer((_) async => false);

      // act
      final result = await usecase.execute(tId);

      // assert
      expect(result, false);
      verify(mockTvSeriesRepository.isAddedToWatchlist(tId));
      verifyNoMoreInteractions(mockTvSeriesRepository);
    });

    test('should propagate exceptions from the repository', () async {
      // arrange
      when(mockTvSeriesRepository.isAddedToWatchlist(tId))
          .thenThrow(Exception('Database error'));

      // act & assert
      expect(() => usecase.execute(tId), throwsA(isA<Exception>()));
      verify(mockTvSeriesRepository.isAddedToWatchlist(tId));
      verifyNoMoreInteractions(mockTvSeriesRepository);
    });
  });
}
