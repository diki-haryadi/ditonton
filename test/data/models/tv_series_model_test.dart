import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    backdropPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    genreIds: [1, 2, 3],
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

  final tTvSeries = TvSeries(
    backdropPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    genreIds: [1, 2, 3],
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

  test('should be a subclass of TvSeries entity', () {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });

  test('should convert from JSON', () {
    // arrange
    final Map<String, dynamic> jsonMap = {
      'backdrop_path': '/path.jpg',
      'first_air_date': '2022-01-01',
      'genre_ids': [1, 2, 3],
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
    };
    // act
    final result = TvSeriesModel.fromJson(jsonMap);
    // assert
    expect(result, tTvSeriesModel);
  });

  test('should convert to JSON', () {
    // act
    final result = tTvSeriesModel.toJson();
    // assert
    final expectedJsonMap = {
      'backdrop_path': '/path.jpg',
      'first_air_date': '2022-01-01',
      'genre_ids': [1, 2, 3],
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
    };
    expect(result, expectedJsonMap);
  });
}