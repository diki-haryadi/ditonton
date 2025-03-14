import 'dart:convert';

import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    backdropPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    genreIds: [1, 2],
    id: 1,
    name: 'Name',
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1000.0,
    posterPath: '/path.jpg',
    voteAverage: 8.0,
    voteCount: 200,
  );

  final tTvSeriesResponseModel =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tv.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, isA<TvSeriesResponse>());
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            'backdrop_path': '/path.jpg',
            'first_air_date': '2022-01-01',
            'genre_ids': [1, 2],
            'id': 1,
            'name': 'Name',
            'origin_country': ['US'],
            'original_language': 'en',
            'original_name': 'Original Name',
            'overview': 'Overview',
            'popularity': 1000.0,
            'poster_path': '/path.jpg',
            'vote_average': 8.0,
            'vote_count': 200,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
