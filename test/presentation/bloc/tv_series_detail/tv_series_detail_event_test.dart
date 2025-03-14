import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_event.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  group('TvSeriesDetailEvent', () {
    test('should support value equality', () {
      expect(
        FetchTvSeriesDetail(1),
        FetchTvSeriesDetail(1),
      );
      expect(
        AddTvSeriesToWatchlist(testTvSeriesDetail),
        AddTvSeriesToWatchlist(testTvSeriesDetail),
      );
      expect(
        RemoveTvSeriesFromWatchlist(testTvSeriesDetail),
        RemoveTvSeriesFromWatchlist(testTvSeriesDetail),
      );
      expect(
        LoadTvSeriesWatchlistStatus(1),
        LoadTvSeriesWatchlistStatus(1),
      );
    });

    test('should return correct props', () {
      expect(
        FetchTvSeriesDetail(1).props,
        [1],
      );
      expect(
        AddTvSeriesToWatchlist(testTvSeriesDetail).props,
        [testTvSeriesDetail],
      );
      expect(
        RemoveTvSeriesFromWatchlist(testTvSeriesDetail).props,
        [testTvSeriesDetail],
      );
      expect(
        LoadTvSeriesWatchlistStatus(1).props,
        [1],
      );
    });
  });
}
