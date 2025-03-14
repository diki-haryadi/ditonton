import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  group('TvSeriesDetailState', () {
    test('should support value equality', () {
      expect(
        TvSeriesDetailState.initial(),
        TvSeriesDetailState.initial(),
      );
    });

    test('should return correct initial state', () {
      expect(
        TvSeriesDetailState.initial(),
        const TvSeriesDetailState(
          tvSeriesState: RequestState.Empty,
          recommendationState: RequestState.Empty,
          tvSeriesDetail: null,
          recommendations: [],
          isAddedToWatchlist: false,
          message: '',
          watchlistMessage: '',
        ),
      );
    });

    test('should return correct props', () {
      expect(
        TvSeriesDetailState.initial().props,
        [
          RequestState.Empty,
          RequestState.Empty,
          null,
          [],
          false,
          '',
          '',
        ],
      );
    });

    test(
        'copyWith should create a new object with same values when no parameters are passed',
        () {
      final originalState = TvSeriesDetailState.initial();
      final copiedState = originalState.copyWith();

      expect(copiedState, originalState);
      expect(identical(copiedState, originalState), false);
    });

    test(
        'copyWith should create a new object with updated values when parameters are passed',
        () {
      final originalState = TvSeriesDetailState.initial();
      final copiedState = originalState.copyWith(
        tvSeriesState: RequestState.Loaded,
        tvSeriesDetail: testTvSeriesDetail,
        recommendationState: RequestState.Loaded,
        recommendations: [testTvSeries],
        isAddedToWatchlist: true,
        message: 'Message',
        watchlistMessage: 'Watchlist Message',
      );

      expect(copiedState, isNot(originalState));
      expect(copiedState.tvSeriesState, RequestState.Loaded);
      expect(copiedState.tvSeriesDetail, testTvSeriesDetail);
      expect(copiedState.recommendationState, RequestState.Loaded);
      expect(copiedState.recommendations, [testTvSeries]);
      expect(copiedState.isAddedToWatchlist, true);
      expect(copiedState.message, 'Message');
      expect(copiedState.watchlistMessage, 'Watchlist Message');
    });
  });
}
