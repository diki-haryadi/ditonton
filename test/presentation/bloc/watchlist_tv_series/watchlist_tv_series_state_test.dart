import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  group('WatchlistTvSeriesState', () {
    test('should support value equality', () {
      expect(
        WatchlistTvSeriesState.initial(),
        WatchlistTvSeriesState.initial(),
      );
    });

    test('should return correct initial state', () {
      expect(
        WatchlistTvSeriesState.initial(),
        const WatchlistTvSeriesState(
          watchlistState: RequestState.Empty,
          watchlistTvSeries: [],
          message: '',
        ),
      );
    });

    test('should return correct props', () {
      final state = WatchlistTvSeriesState(
        watchlistState: RequestState.Loaded,
        watchlistTvSeries: [testWatchlistTvSeries],
        message: 'Message',
      );
      
      expect(state.props, [
        RequestState.Loaded,
        [testWatchlistTvSeries],
        'Message',
      ]);
    });

    test('copyWith should create a new object with updated values when parameters are passed', () {
      final originalState = WatchlistTvSeriesState.initial();
      final copiedState = originalState.copyWith(
        watchlistState: RequestState.Loaded,
        watchlistTvSeries: [testWatchlistTvSeries],
        message: 'Message',
      );
      
      expect(copiedState, isNot(originalState));
      expect(copiedState.watchlistState, RequestState.Loaded);
      expect(copiedState.watchlistTvSeries, [testWatchlistTvSeries]);
      expect(copiedState.message, 'Message');
    });
  });
}