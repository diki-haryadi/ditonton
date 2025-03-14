import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_local_data_source_test.mocks.dart';

@GenerateMocks([DatabaseHelper])
void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late TvSeriesLocalDataSourceImpl dataSource;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource =
        TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  final testTvSeriesTable = TvSeriesTable(
    id: 1,
    name: 'Test Series',
    posterPath: '/test.jpg',
    overview: 'Test overview',
  );

  group('Insert Watchlist', () {
    test('should return success message when insert to database is successful',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvSeriesWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testTvSeriesTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvSeriesWatchlist(testTvSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testTvSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Remove Watchlist', () {
    test(
        'should return success message when remove from database is successful',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvSeriesWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testTvSeriesTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test(
        'should throw DatabaseException when remove from database is unsuccessful',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvSeriesWatchlist(testTvSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testTvSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get TV Series By Id', () {
    final tId = 1;

    test('should return TV Series Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => testTvSeriesTable.toJson());
      // act
      final result = await dataSource.getTvSeriesById(tId);
      // assert
      expect(result, testTvSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('Get Watchlist TV Series', () {
    test('should return list of TvSeriesTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesTable.toJson()]);
      // act
      final result = await dataSource.getWatchlistTvSeries();
      // assert
      expect(result, [testTvSeriesTable]);
    });
  });
}
