import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'save_watchlist_tv_series_test.mocks.dart';

@GenerateMocks([SaveWatchlistTvSeries])
void main() {
  late MockSaveWatchlistTvSeries usecase;

  setUp(() {
    usecase = MockSaveWatchlistTvSeries();
  });

  test('should save tv series to the repository', () async {
    // arrange
    when(usecase.execute(testTvSeriesDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(usecase.execute(testTvSeriesDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}