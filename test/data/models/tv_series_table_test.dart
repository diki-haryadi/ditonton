import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesTable = TvSeriesTable(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  final tTvSeriesDetail = TvSeriesDetail(
    backdropPath: 'backdropPath',
    episodeRunTime: [60],
    firstAirDate: '2022-01-01',
    genres: [Genre(id: 1, name: 'Action')],
    homepage: 'homepage',
    id: 1,
    inProduction: false,
    lastAirDate: '2022-12-31',
    name: 'name',
    numberOfEpisodes: 12,
    numberOfSeasons: 1,
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1000.0,
    posterPath: 'posterPath',
    status: 'Ended',
    tagline: 'tagline',
    type: 'Scripted',
    voteAverage: 8.0,
    voteCount: 200,
  );

  final tTvSeriesMap = {
    'id': 1,
    'name': 'name',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  final tWatchlistTvSeries = TvSeries(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    overview: 'overview',
    backdropPath: null,
    firstAirDate: null,
    genreIds: const [],
    originCountry: const [],
    originalLanguage: '',
    originalName: '',
    popularity: 0,
    voteAverage: 0,
    voteCount: 0,
  );

  test('should convert entity to map', () async {
    // act
    final result = tTvSeriesTable.toJson();
    // assert
    expect(result, tTvSeriesMap);
  });

  test('should convert from map to entity', () async {
    // act
    final result = TvSeriesTable.fromMap(tTvSeriesMap);
    // assert
    expect(result, tTvSeriesTable);
  });

  test('should convert entity TvSeriesDetail to TvSeriesTable', () async {
    // act
    final result = TvSeriesTable.fromEntity(tTvSeriesDetail);
    // assert
    expect(result, tTvSeriesTable);
  });

  test('should convert TvSeriesTable to watchlist TvSeries entity', () async {
    // act
    final result = tTvSeriesTable.toEntity();
    // assert
    expect(result, tWatchlistTvSeries);
  });
}
