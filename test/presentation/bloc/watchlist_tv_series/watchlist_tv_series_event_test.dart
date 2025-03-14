import 'package:ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WatchlistTvSeriesEvent', () {
    test('should support value equality', () {
      expect(
        FetchWatchlistTvSeries(),
        FetchWatchlistTvSeries(),
      );
    });

    test('should return correct props', () {
      expect(
        FetchWatchlistTvSeries().props,
        [],
      );
    });
  });
}