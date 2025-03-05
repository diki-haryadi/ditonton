import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    backdropPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'Test Series',
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Test Series Original',
    overview: 'This is a test series.',
    popularity: 8.5,
    posterPath: '/poster.jpg',
    voteAverage: 7.5,
    voteCount: 100,
  );

  final tTvSeriesModelWithNullPoster = TvSeriesModel(
    backdropPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    genreIds: [1, 2, 3],
    id: 2,
    name: 'Test Series 2',
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Test Series Original 2',
    overview: 'This is a test series 2.',
    popularity: 9.0,
    posterPath: null,
    voteAverage: 8.0,
    voteCount: 150,
  );

  final tTvSeriesResponse = TvSeriesResponse(
    tvSeriesList: [tTvSeriesModel],
  );

  final tTvSeriesResponseMap = {
    'results': [
      {
        'backdrop_path': '/path.jpg',
        'first_air_date': '2022-01-01',
        'genre_ids': [1, 2, 3],
        'id': 1,
        'name': 'Test Series',
        'origin_country': ['US'],
        'original_language': 'en',
        'original_name': 'Test Series Original',
        'overview': 'This is a test series.',
        'popularity': 8.5,
        'poster_path': '/poster.jpg',
        'vote_average': 7.5,
        'vote_count': 100,
      }
    ],
  };

  final tTvSeriesResponseMapWithNullPoster = {
    'results': [
      {
        'backdrop_path': '/path.jpg',
        'first_air_date': '2022-01-01',
        'genre_ids': [1, 2, 3],
        'id': 1,
        'name': 'Test Series',
        'origin_country': ['US'],
        'original_language': 'en',
        'original_name': 'Test Series Original',
        'overview': 'This is a test series.',
        'popularity': 8.5,
        'poster_path': '/poster.jpg',
        'vote_average': 7.5,
        'vote_count': 100,
      },
      {
        'backdrop_path': '/path.jpg',
        'first_air_date': '2022-01-01',
        'genre_ids': [1, 2, 3],
        'id': 2,
        'name': 'Test Series 2',
        'origin_country': ['US'],
        'original_language': 'en',
        'original_name': 'Test Series Original 2',
        'overview': 'This is a test series 2.',
        'popularity': 9.0,
        'poster_path': null,
        'vote_average': 8.0,
        'vote_count': 150,
      }
    ],
  };

  group('TvSeriesResponse', () {
    test('should return a valid model from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap = tTvSeriesResponseMap;

      // act
      final result = TvSeriesResponse.fromJson(jsonMap);

      // assert
      expect(result, tTvSeriesResponse);
    });

    test('should return a JSON map containing proper data', () {
      // act
      final result = tTvSeriesResponse.toJson();

      // assert
      expect(result, tTvSeriesResponseMap);
    });

    test(
        'should filter out TV series with null posterPath when parsing from JSON',
        () {
      // arrange
      final Map<String, dynamic> jsonMap = tTvSeriesResponseMapWithNullPoster;

      // act
      final result = TvSeriesResponse.fromJson(jsonMap);

      // assert
      expect(result.tvSeriesList.length, 1);
      expect(result.tvSeriesList[0], tTvSeriesModel);
      expect(
          result.tvSeriesList
              .where((element) => element.posterPath == null)
              .isEmpty,
          true);
    });

    test('should handle empty results list', () {
      // arrange
      final Map<String, dynamic> jsonMap = {'results': []};

      // act
      final result = TvSeriesResponse.fromJson(jsonMap);

      // assert
      expect(result.tvSeriesList, isEmpty);
    });

    test('should properly implement equals and hashCode', () {
      // arrange
      final tvSeriesResponse1 = TvSeriesResponse(
        tvSeriesList: [tTvSeriesModel],
      );

      final tvSeriesResponse2 = TvSeriesResponse(
        tvSeriesList: [tTvSeriesModel],
      );

      final tvSeriesResponse3 = TvSeriesResponse(
        tvSeriesList: [],
      );

      // assert
      expect(tvSeriesResponse1, tvSeriesResponse2);
      expect(tvSeriesResponse1, isNot(tvSeriesResponse3));
      expect(tvSeriesResponse1.hashCode, tvSeriesResponse2.hashCode);
      expect(tvSeriesResponse1.hashCode, isNot(tvSeriesResponse3.hashCode));
    });

    test('should return correct props values', () {
      // act
      final props = tTvSeriesResponse.props;

      // assert
      expect(props, [tTvSeriesResponse.tvSeriesList]);
    });

    test('should handle full serialization cycle', () {
      // arrange
      final jsonString = json.encode(tTvSeriesResponseMap);

      // act
      final jsonDecoded = json.decode(jsonString);
      final result = TvSeriesResponse.fromJson(jsonDecoded);
      final reEncoded = result.toJson();

      // assert
      expect(result, tTvSeriesResponse);
      expect(reEncoded, tTvSeriesResponseMap);
    });

    test('should handle malformed JSON gracefully', () {
      // arrange
      final malformedJson = {
        'results': [
          {'id': 1, 'name': 'Test Series'} // Missing required fields
        ]
      };

      // act & assert
      expect(() => TvSeriesResponse.fromJson(malformedJson),
          throwsA(isA<Error>()));
    });
  });
}
