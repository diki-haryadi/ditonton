import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  group('MovieDetailEvent', () {
    test('should support value equality', () {
      expect(
        FetchMovieDetail(1),
        FetchMovieDetail(1),
      );
      expect(
        AddMovieToWatchlist(testMovieDetail),
        AddMovieToWatchlist(testMovieDetail),
      );
      expect(
        RemoveMovieFromWatchlist(testMovieDetail),
        RemoveMovieFromWatchlist(testMovieDetail),
      );
      expect(
        LoadWatchlistStatus(1),
        LoadWatchlistStatus(1),
      );
    });

    test('should return correct props', () {
      expect(
        FetchMovieDetail(1).props,
        [1],
      );
      expect(
        AddMovieToWatchlist(testMovieDetail).props,
        [testMovieDetail],
      );
      expect(
        RemoveMovieFromWatchlist(testMovieDetail).props,
        [testMovieDetail],
      );
      expect(
        LoadWatchlistStatus(1).props,
        [1],
      );
    });
  });
}
