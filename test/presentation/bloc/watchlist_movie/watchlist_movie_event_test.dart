import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WatchlistMovieEvent', () {
    test('should support value equality', () {
      expect(
        FetchWatchlistMovies(),
        FetchWatchlistMovies(),
      );
    });

    test('should return correct props', () {
      expect(
        FetchWatchlistMovies().props,
        [],
      );
    });
  });
}