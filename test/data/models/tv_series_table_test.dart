import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tId = 1;
  const tName = "Test Series";
  const tPosterPath = "/path.jpg";
  const tOverview = "Test overview";

  const tTvSeriesTable = TvSeriesTable(
    id: tId,
    name: tName,
    posterPath: tPosterPath,
    overview: tOverview,
  );

  final tTvSeriesDetail = TvSeriesDetail(
    backdropPath: "/backdrop.jpg",
    episodeRunTime: const [60],
    firstAirDate: "2022-01-01",
    genres: [Genre(id: 1, name: "Action")],
    homepage: "https://example.com",
    id: tId,
    inProduction: true,
    lastAirDate: "2022-12-31",
    name: tName,
    numberOfEpisodes: 10,
    numberOfSeasons: 1,
    originalLanguage: "en",
    originalName: "Original Name",
    overview: tOverview,
    popularity: 8.5,
    posterPath: tPosterPath,
    status: "Ended",
    tagline: "Test tagline",
    type: "Scripted",
    voteAverage: 7.5,
    voteCount: 100,
  );

  final tTvSeries = TvSeries(
    backdropPath: null,
    firstAirDate: '',
    genreIds: const [],
    id: tId,
    name: tName,
    originCountry: const [],
    originalLanguage: '',
    originalName: '',
    overview: tOverview,
    popularity: 0,
    posterPath: tPosterPath,
    voteAverage: 0,
    voteCount: 0,
  );

  final tMap = {
    'id': tId,
    'name': tName,
    'posterPath': tPosterPath,
    'overview': tOverview,
  };

  group('TvSeriesTable', () {
    test('should have correct props', () {
      // assert
      expect(tTvSeriesTable.props, [tId, tName, tPosterPath, tOverview]);
    });

    group('fromEntity', () {
      test('should return a valid model from TvSeriesDetail entity', () {
        // act
        final result = TvSeriesTable.fromEntity(tTvSeriesDetail);

        // assert
        expect(result, tTvSeriesTable);
      });
    });

    group('fromMap', () {
      test('should return a valid model from Map', () {
        // act
        final result = TvSeriesTable.fromMap(tMap);

        // assert
        expect(result, tTvSeriesTable);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        // act
        final result = tTvSeriesTable.toJson();

        // assert
        expect(result, tMap);
      });
    });

    group('toMap', () {
      test('should return a Map containing proper data', () {
        // act
        final result = tTvSeriesTable.toMap();

        // assert
        expect(result, tMap);
      });
    });

    group('toEntity', () {
      test('should return a TvSeries entity', () {
        // act
        final result = tTvSeriesTable.toEntity();

        // assert
        expect(result, isA<TvSeries>());
        expect(result.id, tTvSeriesTable.id);
        expect(result.name, tTvSeriesTable.name);
        expect(result.posterPath, tTvSeriesTable.posterPath);
        expect(result.overview, tTvSeriesTable.overview);
      });

      test('should handle null name and overview', () {
        // arrange
        const tvSeriesTableWithNulls = TvSeriesTable(
          id: tId,
          name: null,
          posterPath: tPosterPath,
          overview: null,
        );

        // act
        final result = tvSeriesTableWithNulls.toEntity();

        // assert
        expect(result.name, '');
        expect(result.overview, '');
      });
    });

    group('equality', () {
      test('should return true when objects have the same properties', () {
        // arrange
        const tvSeriesTable2 = TvSeriesTable(
          id: tId,
          name: tName,
          posterPath: tPosterPath,
          overview: tOverview,
        );

        // assert
        expect(tTvSeriesTable, tvSeriesTable2);
        expect(tTvSeriesTable.hashCode, tvSeriesTable2.hashCode);
      });

      test('should return false when objects have different properties', () {
        // arrange
        const tvSeriesTable2 = TvSeriesTable(
          id: 2,
          name: tName,
          posterPath: tPosterPath,
          overview: tOverview,
        );

        // assert
        expect(tTvSeriesTable == tvSeriesTable2, false);
        expect(tTvSeriesTable.hashCode == tvSeriesTable2.hashCode, false);
      });
    });

    test('should convert nullable fields correctly', () {
      // arrange
      const tvSeriesTableWithNulls = TvSeriesTable(
        id: tId,
        name: null,
        posterPath: null,
        overview: null,
      );

      final mapWithNulls = {
        'id': tId,
        'name': null,
        'posterPath': null,
        'overview': null,
      };

      // act
      final toJson = tvSeriesTableWithNulls.toJson();
      final toMap = tvSeriesTableWithNulls.toMap();
      final fromMap = TvSeriesTable.fromMap(mapWithNulls);

      // assert
      expect(toJson, mapWithNulls);
      expect(toMap, mapWithNulls);
      expect(fromMap, tvSeriesTableWithNulls);
    });
  });
}
