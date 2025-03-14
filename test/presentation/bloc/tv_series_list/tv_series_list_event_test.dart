import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TvSeriesListEvent', () {
    test('should support value equality', () {
      expect(
        FetchNowPlayingTvSeries(),
        FetchNowPlayingTvSeries(),
      );
      expect(
        FetchPopularTvSeries(),
        FetchPopularTvSeries(),
      );
      expect(
        FetchTopRatedTvSeries(),
        FetchTopRatedTvSeries(),
      );
    });

    test('should return correct props', () {
      expect(
        FetchNowPlayingTvSeries().props,
        [],
      );
      expect(
        FetchPopularTvSeries().props,
        [],
      );
      expect(
        FetchTopRatedTvSeries().props,
        [],
      );
    });
  });
}
