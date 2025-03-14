import 'package:ditonton/presentation/bloc/tv_series_search/tv_series_search_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TvSeriesSearchEvent', () {
    test('should support value equality', () {
      expect(
        QueryChanged('query'),
        QueryChanged('query'),
      );
    });

    test('should return correct props', () {
      expect(
        QueryChanged('query').props,
        ['query'],
      );
    });
  });
}