import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_local_data_source_test.mocks.dart';

@GenerateMocks([DatabaseHelper])
void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late MovieLocalDataSourceImpl dataSource;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  final testMovieTable = MovieTable(
    id: 1,
    title: 'Test Movie',
    posterPath: '/test.jpg',
    overview: 'Test overview',
  );

  group('Insert Watchlist', () {
    test('should return success message when insert to database is successful',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Remove Watchlist', () {
    test(
        'should return success message when remove from database is successful',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test(
        'should throw DatabaseException when remove from database is unsuccessful',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie By Id', () {
    final tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId))
          .thenAnswer((_) async => testMovieTable.toJson());
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, testMovieTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, null);
    });
  });

  group('Get Watchlist Movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieTable.toJson()]);
      // act
      final result = await dataSource.getWatchlistMovies();
      // assert
      expect(result, [testMovieTable]);
    });
  });
}
