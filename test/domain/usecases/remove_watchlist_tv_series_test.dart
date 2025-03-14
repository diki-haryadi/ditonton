import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'remove_watchlist_tv_series_test.mocks.dart';

@GenerateMocks([RemoveWatchlistTvSeries])
void main() {
  late MockRemoveWatchlistTvSeries usecase;

  setUp(() {
    usecase = MockRemoveWatchlistTvSeries();
  });

  test('should remove watchlist tv series from repository', () async {
    // arrange
    when(usecase.execute(testTvSeriesDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(usecase.execute(testTvSeriesDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}