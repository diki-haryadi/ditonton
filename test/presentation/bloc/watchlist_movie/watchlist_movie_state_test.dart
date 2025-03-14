import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  group('WatchlistMovieState', () {
    test('should support value equality', () {
      expect(
        WatchlistMovieState.initial(),
        WatchlistMovieState.initial(),
      );
    });

    test('should return correct initial state', () {
      expect(
        WatchlistMovieState.initial(),
        const WatchlistMovieState(
          watchlistState: RequestState.Empty,
          watchlistMovies: [],
          message: '',
        ),
      );
    });

    test('should return correct props', () {
      final state = WatchlistMovieState(
        watchlistState: RequestState.Loaded,
        watchlistMovies: [testWatchlistMovie],
        message: 'Message',
      );
      
      expect(state.props, [
        RequestState.Loaded,
        [testWatchlistMovie],
        'Message',
      ]);
    });

    test('copyWith should create a new object with updated values when parameters are passed', () {
      final originalState = WatchlistMovieState.initial();
      final copiedState = originalState.copyWith(
        watchlistState: RequestState.Loaded,
        watchlistMovies: [testWatchlistMovie],
        message: 'Message',
      );
      
      expect(copiedState, isNot(originalState));
      expect(copiedState.watchlistState, RequestState.Loaded);
      expect(copiedState.watchlistMovies, [testWatchlistMovie]);
      expect(copiedState.message, 'Message');
    });
  });
}