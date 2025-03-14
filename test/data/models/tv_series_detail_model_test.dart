import 'dart:convert';

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvSeriesDetailModel = TvSeriesDetailResponse(
    backdropPath: '/path.jpg',
    episodeRunTime: [60],
    firstAirDate: '2022-01-01',
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: 'https://example.com',
    id: 1,
    inProduction: false,
    lastAirDate: '2022-12-31',
    name: 'Name',
    numberOfEpisodes: 12,
    numberOfSeasons: 1,
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1000.0,
    posterPath: '/path.jpg',
    status: 'Ended',
    tagline: 'Tagline',
    type: 'Scripted',
    voteAverage: 8.0,
    voteCount: 200,
  );

  final tTvSeriesDetail = TvSeriesDetail(
    backdropPath: '/path.jpg',
    episodeRunTime: [60],
    firstAirDate: '2022-01-01',
    genres: [Genre(id: 1, name: 'Action')],
    homepage: 'https://example.com',
    id: 1,
    inProduction: false,
    lastAirDate: '2022-12-31',
    name: 'Name',
    numberOfEpisodes: 12,
    numberOfSeasons: 1,
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1000.0,
    posterPath: '/path.jpg',
    status: 'Ended',
    tagline: 'Tagline',
    type: 'Scripted',
    voteAverage: 8.0,
    voteCount: 200,
  );

  test('should be a subclass of TvSeriesDetail entity', () {
    final result = tTvSeriesDetailModel.toEntity();
    expect(result, tTvSeriesDetail);
  });

  test('should convert from JSON', () {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/tv_series_detail.json'));
    // act
    final result = TvSeriesDetailResponse.fromJson(jsonMap);
    // assert
    expect(result, isA<TvSeriesDetailResponse>());
  });

  test('should convert to JSON', () {
    // act
    final result = tTvSeriesDetailModel.toJson();
    // assert
    final expectedJsonMap = {
      'backdrop_path': '/path.jpg',
      'episode_run_time': [60],
      'first_air_date': '2022-01-01',
      'genres': [
        {
          'id': 1,
          'name': 'Action'
        }
      ],
      'homepage': 'https://example.com',
      'id': 1,
      'in_production': false,
      'last_air_date': '2022-12-31',
      'name': 'Name',
      'number_of_episodes': 12,
      'number_of_seasons': 1,
      'original_language': 'en',
      'original_name': 'Original Name',
      'overview': 'Overview',
      'popularity': 1000.0,
      'poster_path': '/path.jpg',
      'status': 'Ended',
      'tagline': 'Tagline',
      'type': 'Scripted',
      'vote_average': 8.0,
      'vote_count': 200,
    };
    expect(result, expectedJsonMap);
  });
}