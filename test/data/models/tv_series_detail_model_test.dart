import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

void main() {
  final tGenreModel = GenreModel(id: 1, name: 'Action');

  final tTvSeriesDetailResponse = TvSeriesDetailResponse(
    backdropPath: '/path.jpg',
    episodeRunTime: [60, 45],
    firstAirDate: '2022-01-01',
    genres: [tGenreModel],
    homepage: 'https://example.com',
    id: 1,
    inProduction: true,
    lastAirDate: '2022-12-31',
    name: 'Test Series',
    numberOfEpisodes: 10,
    numberOfSeasons: 1,
    originalLanguage: 'en',
    originalName: 'Test Series Original',
    overview: 'This is a test series.',
    popularity: 8.5,
    posterPath: '/poster.jpg',
    status: 'Ended',
    tagline: 'A test tagline',
    type: 'Scripted',
    voteAverage: 7.5,
    voteCount: 100,
  );

  final Map<String, dynamic> jsonMap = {
    'backdrop_path': '/path.jpg',
    'episode_run_time': [60, 45],
    'first_air_date': '2022-01-01',
    'genres': [
      {'id': 1, 'name': 'Action'}
    ],
    'homepage': 'https://example.com',
    'id': 1,
    'in_production': true,
    'last_air_date': '2022-12-31',
    'name': 'Test Series',
    'number_of_episodes': 10,
    'number_of_seasons': 1,
    'original_language': 'en',
    'original_name': 'Test Series Original',
    'overview': 'This is a test series.',
    'popularity': 8.5,
    'poster_path': '/poster.jpg',
    'status': 'Ended',
    'tagline': 'A test tagline',
    'type': 'Scripted',
    'vote_average': 7.5,
    'vote_count': 100,
  };

  group('TvSeriesDetailResponse', () {
    test('should be a subclass of TvSeriesDetail entity', () {
      // assert
      final result = tTvSeriesDetailResponse.toEntity();
      expect(result, isA<TvSeriesDetail>());
    });

    test('should return a valid model from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap = {
        'backdrop_path': '/path.jpg',
        'episode_run_time': [60, 45],
        'first_air_date': '2022-01-01',
        'genres': [
          {'id': 1, 'name': 'Action'}
        ],
        'homepage': 'https://example.com',
        'id': 1,
        'in_production': true,
        'last_air_date': '2022-12-31',
        'name': 'Test Series',
        'number_of_episodes': 10,
        'number_of_seasons': 1,
        'original_language': 'en',
        'original_name': 'Test Series Original',
        'overview': 'This is a test series.',
        'popularity': 8.5,
        'poster_path': '/poster.jpg',
        'status': 'Ended',
        'tagline': 'A test tagline',
        'type': 'Scripted',
        'vote_average': 7.5,
        'vote_count': 100,
      };

      // act
      final result = TvSeriesDetailResponse.fromJson(jsonMap);

      // assert
      expect(result, tTvSeriesDetailResponse);
    });

    test('should return a JSON map containing proper data', () {
      // act
      final result = tTvSeriesDetailResponse.toJson();

      // assert
      expect(result, jsonMap);
    });

    test('should convert to TvSeriesDetail entity correctly', () {
      // act
      final entity = tTvSeriesDetailResponse.toEntity();

      // assert
      expect(entity.backdropPath, tTvSeriesDetailResponse.backdropPath);
      expect(entity.episodeRunTime, tTvSeriesDetailResponse.episodeRunTime);
      expect(entity.firstAirDate, tTvSeriesDetailResponse.firstAirDate);
      expect(entity.genres.length, tTvSeriesDetailResponse.genres.length);
      expect(entity.homepage, tTvSeriesDetailResponse.homepage);
      expect(entity.id, tTvSeriesDetailResponse.id);
      expect(entity.inProduction, tTvSeriesDetailResponse.inProduction);
      expect(entity.lastAirDate, tTvSeriesDetailResponse.lastAirDate);
      expect(entity.name, tTvSeriesDetailResponse.name);
      expect(entity.numberOfEpisodes, tTvSeriesDetailResponse.numberOfEpisodes);
      expect(entity.numberOfSeasons, tTvSeriesDetailResponse.numberOfSeasons);
      expect(entity.originalLanguage, tTvSeriesDetailResponse.originalLanguage);
      expect(entity.originalName, tTvSeriesDetailResponse.originalName);
      expect(entity.overview, tTvSeriesDetailResponse.overview);
      expect(entity.popularity, tTvSeriesDetailResponse.popularity);
      expect(entity.posterPath, tTvSeriesDetailResponse.posterPath);
      expect(entity.status, tTvSeriesDetailResponse.status);
      expect(entity.tagline, tTvSeriesDetailResponse.tagline);
      expect(entity.type, tTvSeriesDetailResponse.type);
      expect(entity.voteAverage, tTvSeriesDetailResponse.voteAverage);
      expect(entity.voteCount, tTvSeriesDetailResponse.voteCount);
    });

    test('should properly implement equals and hashCode', () {
      // arrange
      final tvSeriesDetail1 = TvSeriesDetailResponse(
        backdropPath: '/path.jpg',
        episodeRunTime: [60, 45],
        firstAirDate: '2022-01-01',
        genres: [tGenreModel],
        homepage: 'https://example.com',
        id: 1,
        inProduction: true,
        lastAirDate: '2022-12-31',
        name: 'Test Series',
        numberOfEpisodes: 10,
        numberOfSeasons: 1,
        originalLanguage: 'en',
        originalName: 'Test Series Original',
        overview: 'This is a test series.',
        popularity: 8.5,
        posterPath: '/poster.jpg',
        status: 'Ended',
        tagline: 'A test tagline',
        type: 'Scripted',
        voteAverage: 7.5,
        voteCount: 100,
      );

      final tvSeriesDetail2 = TvSeriesDetailResponse(
        backdropPath: '/path.jpg',
        episodeRunTime: [60, 45],
        firstAirDate: '2022-01-01',
        genres: [tGenreModel],
        homepage: 'https://example.com',
        id: 1,
        inProduction: true,
        lastAirDate: '2022-12-31',
        name: 'Test Series',
        numberOfEpisodes: 10,
        numberOfSeasons: 1,
        originalLanguage: 'en',
        originalName: 'Test Series Original',
        overview: 'This is a test series.',
        popularity: 8.5,
        posterPath: '/poster.jpg',
        status: 'Ended',
        tagline: 'A test tagline',
        type: 'Scripted',
        voteAverage: 7.5,
        voteCount: 100,
      );

      final tvSeriesDetail3 = TvSeriesDetailResponse(
        backdropPath: '/different_path.jpg',
        episodeRunTime: [60, 45],
        firstAirDate: '2022-01-01',
        genres: [tGenreModel],
        homepage: 'https://example.com',
        id: 1,
        inProduction: true,
        lastAirDate: '2022-12-31',
        name: 'Test Series',
        numberOfEpisodes: 10,
        numberOfSeasons: 1,
        originalLanguage: 'en',
        originalName: 'Test Series Original',
        overview: 'This is a test series.',
        popularity: 8.5,
        posterPath: '/poster.jpg',
        status: 'Ended',
        tagline: 'A test tagline',
        type: 'Scripted',
        voteAverage: 7.5,
        voteCount: 100,
      );

      // assert
      expect(tvSeriesDetail1, tvSeriesDetail2);
      expect(tvSeriesDetail1, isNot(tvSeriesDetail3));
      expect(tvSeriesDetail1.hashCode, tvSeriesDetail2.hashCode);
      expect(tvSeriesDetail1.hashCode, isNot(tvSeriesDetail3.hashCode));
    });

    test('should handle null backdropPath', () {
      // arrange
      final jsonWithNullBackdrop = Map<String, dynamic>.from(jsonMap);
      jsonWithNullBackdrop['backdrop_path'] = null;

      // act
      final result = TvSeriesDetailResponse.fromJson(jsonWithNullBackdrop);

      // assert
      expect(result.backdropPath, null);
    });
  });
}
