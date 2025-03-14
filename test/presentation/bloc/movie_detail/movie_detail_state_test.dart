import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  group('MovieDetailState', () {
    test('should support value equality', () {
      expect(
        MovieDetailState.initial(),
        MovieDetailState.initial(),
      );
    });

    test('should return correct initial state', () {
      expect(
        MovieDetailState.initial(),
        const MovieDetailState(
          movieState: RequestState.Empty,
          recommendationState: RequestState.Empty,
          movieDetail: null,
          recommendations: [],
          isAddedToWatchlist: false,
          message: '',
          watchlistMessage: '',
        ),
      );
    });

    test('should return correct props', () {
      expect(
        MovieDetailState.initial().props,
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
      final originalState = MovieDetailState.initial();
      final copiedState = originalState.copyWith();

      expect(copiedState, originalState);
      expect(identical(copiedState, originalState), false);
    });

    test(
        'copyWith should create a new object with updated values when parameters are passed',
        () {
      final originalState = MovieDetailState.initial();
      final copiedState = originalState.copyWith(
        movieState: RequestState.Loaded,
        movieDetail: testMovieDetail,
        recommendationState: RequestState.Loaded,
        recommendations: [testMovie],
        isAddedToWatchlist: true,
        message: 'Message',
        watchlistMessage: 'Watchlist Message',
      );

      expect(copiedState, isNot(originalState));
      expect(copiedState.movieState, RequestState.Loaded);
      expect(copiedState.movieDetail, testMovieDetail);
      expect(copiedState.recommendationState, RequestState.Loaded);
      expect(copiedState.recommendations, [testMovie]);
      expect(copiedState.isAddedToWatchlist, true);
      expect(copiedState.message, 'Message');
      expect(copiedState.watchlistMessage, 'Watchlist Message');
    });
  });
}
