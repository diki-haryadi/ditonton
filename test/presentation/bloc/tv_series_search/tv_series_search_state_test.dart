import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_search/tv_series_search_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TvSeriesSearchState', () {
    test('should support value equality', () {
      expect(
        TvSeriesSearchState.initial(),
        TvSeriesSearchState.initial(),
      );
    });

    test('should return correct initial state', () {
      expect(
        TvSeriesSearchState.initial(),
        const TvSeriesSearchState(
          state: RequestState.Empty,
          searchResult: [],
          message: '',
        ),
      );
    });

    test('should return correct props', () {
      final state = TvSeriesSearchState.initial();
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
      final tvSeries = TvSeries(
        backdropPath: 'backdropPath',
        firstAirDate: 'firstAirDate',
        genreIds: [1, 2, 3],
        id: 1,
        name: 'name',
        originCountry: ['US'],
        originalLanguage: 'originalLanguage',
        originalName: 'originalName',
        overview: 'overview',
        popularity: 1,
        posterPath: 'posterPath',
        voteAverage: 1,
        voteCount: 1,
      );
      
      final originalState = TvSeriesSearchState.initial();
      final copiedState = originalState.copyWith(
        state: RequestState.Loaded,
        searchResult: [tvSeries],
        message: 'Message',
      );
      
      expect(copiedState, isNot(originalState));
      expect(copiedState.state, RequestState.Loaded);
      expect(copiedState.searchResult, [tvSeries]);
      expect(copiedState.message, 'Message');
    });
  });
}