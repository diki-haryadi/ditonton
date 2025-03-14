import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TvSeriesListState', () {
    test('should support value equality', () {
      expect(
        TvSeriesListState.initial(),
        TvSeriesListState.initial(),
      );
    });

    test('should return correct initial state', () {
      expect(
        TvSeriesListState.initial(),
        const TvSeriesListState(
          nowPlayingState: RequestState.Empty,
          popularTvSeriesState: RequestState.Empty,
          topRatedTvSeriesState: RequestState.Empty,
          nowPlayingTvSeries: [],
          popularTvSeries: [],
          topRatedTvSeries: [],
          message: '',
        ),
      );
    });

    test('should return correct props', () {
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
      
      final state = TvSeriesListState(
        nowPlayingState: RequestState.Loaded,
        popularTvSeriesState: RequestState.Loaded,
        topRatedTvSeriesState: RequestState.Loaded,
        nowPlayingTvSeries: [tvSeries],
        popularTvSeries: [tvSeries],
        topRatedTvSeries: [tvSeries],
        message: 'Message',
      );
      
      expect(state.props, [
        RequestState.Loaded,
        RequestState.Loaded,
        RequestState.Loaded,
        [tvSeries],
        [tvSeries],
        [tvSeries],
        'Message',
      ]);
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
      
      final originalState = TvSeriesListState.initial();
      final copiedState = originalState.copyWith(
        nowPlayingState: RequestState.Loaded,
        popularTvSeriesState: RequestState.Loaded,
        topRatedTvSeriesState: RequestState.Loaded,
        nowPlayingTvSeries: [tvSeries],
        popularTvSeries: [tvSeries],
        topRatedTvSeries: [tvSeries],
        message: 'Message',
      );
      
      expect(copiedState, isNot(originalState));
      expect(copiedState.nowPlayingState, RequestState.Loaded);
      expect(copiedState.popularTvSeriesState, RequestState.Loaded);
      expect(copiedState.topRatedTvSeriesState, RequestState.Loaded);
      expect(copiedState.nowPlayingTvSeries, [tvSeries]);
      expect(copiedState.popularTvSeries, [tvSeries]);
      expect(copiedState.topRatedTvSeries, [tvSeries]);
      expect(copiedState.message, 'Message');
    });
  });
}