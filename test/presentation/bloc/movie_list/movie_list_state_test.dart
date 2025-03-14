import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovieListState', () {
    test('should support value equality', () {
      expect(
        MovieListState.initial(),
        MovieListState.initial(),
      );
    });

    test('should return correct initial state', () {
      expect(
        MovieListState.initial(),
        MovieListState(
          nowPlayingState: RequestState.Empty,
          popularMoviesState: RequestState.Empty,
          topRatedMoviesState: RequestState.Empty,
          nowPlayingMovies: [],
          popularMovies: [],
          topRatedMovies: [],
          message: '',
        ),
      );
    });

    test('should return correct props', () {
      final movie = Movie(
        adult: false,
        backdropPath: 'backdropPath',
        genreIds: [1, 2, 3],
        id: 1,
        originalTitle: 'originalTitle',
        overview: 'overview',
        popularity: 1,
        posterPath: 'posterPath',
        releaseDate: 'releaseDate',
        title: 'title',
        video: false,
        voteAverage: 1,
        voteCount: 1,
      );

      final state = MovieListState(
        nowPlayingState: RequestState.Loaded,
        popularMoviesState: RequestState.Loaded,
        topRatedMoviesState: RequestState.Loaded,
        nowPlayingMovies: [movie],
        popularMovies: [movie],
        topRatedMovies: [movie],
        message: 'Message',
      );

      expect(state.props, [
        RequestState.Loaded,
        RequestState.Loaded,
        RequestState.Loaded,
        [movie],
        [movie],
        [movie],
        'Message',
      ]);
    });

    test(
        'copyWith should create a new object with updated values when parameters are passed',
        () {
      final movie = Movie(
        adult: false,
        backdropPath: 'backdropPath',
        genreIds: [1, 2, 3],
        id: 1,
        originalTitle: 'originalTitle',
        overview: 'overview',
        popularity: 1,
        posterPath: 'posterPath',
        releaseDate: 'releaseDate',
        title: 'title',
        video: false,
        voteAverage: 1,
        voteCount: 1,
      );

      final originalState = MovieListState.initial();
      final copiedState = originalState.copyWith(
        nowPlayingState: RequestState.Loaded,
        popularMoviesState: RequestState.Loaded,
        topRatedMoviesState: RequestState.Loaded,
        nowPlayingMovies: [movie],
        popularMovies: [movie],
        topRatedMovies: [movie],
        message: 'Message',
      );

      expect(copiedState, isNot(originalState));
      expect(copiedState.nowPlayingState, RequestState.Loaded);
      expect(copiedState.popularMoviesState, RequestState.Loaded);
      expect(copiedState.topRatedMoviesState, RequestState.Loaded);
      expect(copiedState.nowPlayingMovies, [movie]);
      expect(copiedState.popularMovies, [movie]);
      expect(copiedState.topRatedMovies, [movie]);
      expect(copiedState.message, 'Message');
    });
  });
}
