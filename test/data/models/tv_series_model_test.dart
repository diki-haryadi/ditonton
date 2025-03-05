import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    backdropPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'Test Series',
    originCountry: ['US', 'UK'],
    originalLanguage: 'en',
    originalName: 'Test Series Original',
    overview: 'This is a test series.',
    popularity: 8.5,
    posterPath: '/poster.jpg',
    voteAverage: 7.5,
    voteCount: 100,
  );

  final tTvSeries = TvSeries(
    backdropPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'Test Series',
    originCountry: ['US', 'UK'],
    originalLanguage: 'en',
    originalName: 'Test Series Original',
    overview: 'This is a test series.',
    popularity: 8.5,
    posterPath: '/poster.jpg',
    voteAverage: 7.5,
    voteCount: 100,
  );

  final Map<String, dynamic> jsonMap = {
    'backdrop_path': '/path.jpg',
    'first_air_date': '2022-01-01',
    'genre_ids': [1, 2, 3],
    'id': 1,
    'name': 'Test Series',
    'origin_country': ['US', 'UK'],
    'original_language': 'en',
    'original_name': 'Test Series Original',
    'overview': 'This is a test series.',
    'popularity': 8.5,
    'poster_path': '/poster.jpg',
    'vote_average': 7.5,
    'vote_count': 100,
  };

  group('TvSeriesModel', () {
    test('should be a subclass of TvSeries entity', () {
      // assert
      final result = tTvSeriesModel.toEntity();
      expect(result, isA<TvSeries>());
    });

    test('should convert to TvSeries entity correctly', () {
      // act
      final entity = tTvSeriesModel.toEntity();

      // assert
      expect(entity.backdropPath, tTvSeriesModel.backdropPath);
      expect(entity.firstAirDate, tTvSeriesModel.firstAirDate);
      expect(entity.genreIds, tTvSeriesModel.genreIds);
      expect(entity.id, tTvSeriesModel.id);
      expect(entity.name, tTvSeriesModel.name);
      expect(entity.originCountry, tTvSeriesModel.originCountry);
      expect(entity.originalLanguage, tTvSeriesModel.originalLanguage);
      expect(entity.originalName, tTvSeriesModel.originalName);
      expect(entity.overview, tTvSeriesModel.overview);
      expect(entity.popularity, tTvSeriesModel.popularity);
      expect(entity.posterPath, tTvSeriesModel.posterPath);
      expect(entity.voteAverage, tTvSeriesModel.voteAverage);
      expect(entity.voteCount, tTvSeriesModel.voteCount);
    });

    test('should return a valid model from JSON', () {
      // act
      final result = TvSeriesModel.fromJson(jsonMap);

      // assert
      expect(result, tTvSeriesModel);
    });

    test('should return a JSON map containing proper data', () {
      // act
      final result = tTvSeriesModel.toJson();

      // assert
      expect(result, jsonMap);
    });

    group('fromJson', () {
      test('should handle null backdropPath', () {
        // arrange
        final jsonWithNullBackdrop = Map<String, dynamic>.from(jsonMap);
        jsonWithNullBackdrop['backdrop_path'] = null;

        // act
        final result = TvSeriesModel.fromJson(jsonWithNullBackdrop);

        // assert
        expect(result.backdropPath, null);
      });

      test('should handle null firstAirDate', () {
        // arrange
        final jsonWithNullFirstAirDate = Map<String, dynamic>.from(jsonMap);
        jsonWithNullFirstAirDate['first_air_date'] = null;

        // act
        final result = TvSeriesModel.fromJson(jsonWithNullFirstAirDate);

        // assert
        expect(result.firstAirDate, null);
      });

      test('should handle null posterPath', () {
        // arrange
        final jsonWithNullPosterPath = Map<String, dynamic>.from(jsonMap);
        jsonWithNullPosterPath['poster_path'] = null;

        // act
        final result = TvSeriesModel.fromJson(jsonWithNullPosterPath);

        // assert
        expect(result.posterPath, null);
      });

      test('should properly parse double values', () {
        // arrange
        final jsonWithIntValues = Map<String, dynamic>.from(jsonMap);
        jsonWithIntValues['popularity'] = 8;
        jsonWithIntValues['vote_average'] = 7;

        // act
        final result = TvSeriesModel.fromJson(jsonWithIntValues);

        // assert
        expect(result.popularity, 8.0);
        expect(result.voteAverage, 7.0);
      });
    });

    test('should properly implement equals and hashCode', () {
      // arrange
      final tvSeriesModel1 = TvSeriesModel(
        backdropPath: '/path.jpg',
        firstAirDate: '2022-01-01',
        genreIds: [1, 2, 3],
        id: 1,
        name: 'Test Series',
        originCountry: ['US', 'UK'],
        originalLanguage: 'en',
        originalName: 'Test Series Original',
        overview: 'This is a test series.',
        popularity: 8.5,
        posterPath: '/poster.jpg',
        voteAverage: 7.5,
        voteCount: 100,
      );

      final tvSeriesModel2 = TvSeriesModel(
        backdropPath: '/path.jpg',
        firstAirDate: '2022-01-01',
        genreIds: [1, 2, 3],
        id: 1,
        name: 'Test Series',
        originCountry: ['US', 'UK'],
        originalLanguage: 'en',
        originalName: 'Test Series Original',
        overview: 'This is a test series.',
        popularity: 8.5,
        posterPath: '/poster.jpg',
        voteAverage: 7.5,
        voteCount: 100,
      );

      final tvSeriesModel3 = TvSeriesModel(
        backdropPath: '/different_path.jpg',
        firstAirDate: '2022-01-01',
        genreIds: [1, 2, 3],
        id: 1,
        name: 'Test Series',
        originCountry: ['US', 'UK'],
        originalLanguage: 'en',
        originalName: 'Test Series Original',
        overview: 'This is a test series.',
        popularity: 8.5,
        posterPath: '/poster.jpg',
        voteAverage: 7.5,
        voteCount: 100,
      );

      // assert
      expect(tvSeriesModel1, tvSeriesModel2);
      expect(tvSeriesModel1, isNot(tvSeriesModel3));
      expect(tvSeriesModel1.hashCode, tvSeriesModel2.hashCode);
      expect(tvSeriesModel1.hashCode, isNot(tvSeriesModel3.hashCode));
    });

    test('should return correct props values', () {
      // act
      final props = tTvSeriesModel.props;

      // assert
      expect(props, [
        tTvSeriesModel.backdropPath,
        tTvSeriesModel.firstAirDate,
        tTvSeriesModel.genreIds,
        tTvSeriesModel.id,
        tTvSeriesModel.name,
        tTvSeriesModel.originCountry,
        tTvSeriesModel.originalLanguage,
        tTvSeriesModel.originalName,
        tTvSeriesModel.overview,
        tTvSeriesModel.popularity,
        tTvSeriesModel.posterPath,
        tTvSeriesModel.voteAverage,
        tTvSeriesModel.voteCount,
      ]);
    });

    test('should handle string serialization and deserialization', () {
      // arrange
      final jsonString = json.encode(jsonMap);

      // act
      final jsonDecoded = json.decode(jsonString);
      final result = TvSeriesModel.fromJson(jsonDecoded);

      // assert
      expect(result, tTvSeriesModel);
    });
  });
}
