import 'package:ditonton/presentation/bloc/movie_search/movie_search_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovieSearchEvent', () {
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
