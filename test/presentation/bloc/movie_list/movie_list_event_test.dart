import 'package:ditonton/presentation/bloc/movie_list/movie_list_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovieListEvent', () {
    test('should support value equality', () {
      expect(
        FetchNowPlayingMovies(),
        FetchNowPlayingMovies(),
      );
      expect(
        FetchPopularMovies(),
        FetchPopularMovies(),
      );
      expect(
        FetchTopRatedMovies(),
        FetchTopRatedMovies(),
      );
    });

    test('should return correct props', () {
      expect(
        FetchNowPlayingMovies().props,
        [],
      );
      expect(
        FetchPopularMovies().props,
        [],
      );
      expect(
        FetchTopRatedMovies().props,
        [],
      );
    });
  });
}
