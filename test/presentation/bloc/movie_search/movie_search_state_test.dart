import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovieSearchState', () {
    test('should support value equality', () {
      expect(
        MovieSearchState.initial(),
        MovieSearchState.initial(),
      );
    });

    test('should return correct initial state', () {
      expect(
        MovieSearchState.initial(),
        const MovieSearchState(
          state: RequestState.Empty,
          searchResult: [],
          message: '',
        ),
      );
    });

    test('should return correct props', () {
      final state = MovieSearchState.initial();
      expect(
        state.props,
        [
          RequestState.Empty,
          [],
          '',
        ],
      );
    });

    test('copyWith should create a new object with updated values when parameters are passed', () {
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
      
      final originalState = MovieSearchState.initial();
      final copiedState = originalState.copyWith(
        state: RequestState.Loaded,
        searchResult: [movie],
        message: 'Message',
      );
      
      expect(copiedState, isNot(originalState));
      expect(copiedState.state, RequestState.Loaded);
      expect(copiedState.searchResult, [movie]);
      expect(copiedState.message, 'Message');
    });
  });
}