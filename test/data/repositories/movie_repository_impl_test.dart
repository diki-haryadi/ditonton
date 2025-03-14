import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

@GenerateMocks([
  MovieRemoteDataSource,
  MovieLocalDataSource,
])
void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'Original Title',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    releaseDate: '2020-01-01',
    title: 'Title',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tMovie = tMovieModel.toEntity();
  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];

  group('Now Playing Movies', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingMovies())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getNowPlayingMovies();
      // assert
      verify(mockRemoteDataSource.getNowPlayingMovies());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingMovies())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingMovies();
      // assert
      verify(mockRemoteDataSource.getNowPlayingMovies());
      expect(result, equals(Left(ServerFailure('Server error occurred'))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingMovies())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingMovies();
      // assert
      verify(mockRemoteDataSource.getNowPlayingMovies());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test(
        'should return connection failure when the call to remote data source throws http.ClientException',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingMovies())
          .thenThrow(http.ClientException('Network connection problem'));
      // act
      final result = await repository.getNowPlayingMovies();
      // assert
      verify(mockRemoteDataSource.getNowPlayingMovies());
      expect(result,
          equals(Left(ConnectionFailure('Network connection problem'))));
    });

    test(
        'should return connection failure when the call to remote data source throws ConnectionFailureException',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingMovies())
          .thenThrow(ConnectionFailureException('Connection failure'));
      // act
      final result = await repository.getNowPlayingMovies();
      // assert
      verify(mockRemoteDataSource.getNowPlayingMovies());
      expect(result, equals(Left(ConnectionFailure('Connection failure'))));
    });

    test(
        'should return connection failure when the call to remote data source throws unexpected exception',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingMovies())
          .thenThrow(Exception('Unexpected error'));
      // act
      final result = await repository.getNowPlayingMovies();
      // assert
      verify(mockRemoteDataSource.getNowPlayingMovies());
      expect(
          result,
          equals(Left(ConnectionFailure(
              'Unexpected error: Exception: Unexpected error'))));
    });
  });

  group('Popular Movies', () {
    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularMovies())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getPopularMovies();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularMovies())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularMovies();
      // assert
      expect(result, Left(ServerFailure('Server error occurred')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularMovies())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularMovies();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });

    test(
        'should return connection failure when the call to remote data source throws http.ClientException',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularMovies())
          .thenThrow(http.ClientException('Network connection problem'));
      // act
      final result = await repository.getPopularMovies();
      // assert
      expect(result,
          equals(Left(ConnectionFailure('Network connection problem'))));
    });

    test(
        'should return connection failure when the call to remote data source throws ConnectionFailureException',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularMovies())
          .thenThrow(ConnectionFailureException('Connection failure'));
      // act
      final result = await repository.getPopularMovies();
      // assert
      expect(result, equals(Left(ConnectionFailure('Connection failure'))));
    });

    test(
        'should return connection failure when the call to remote data source throws unexpected exception',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularMovies())
          .thenThrow(Exception('Unexpected error'));
      // act
      final result = await repository.getPopularMovies();
      // assert
      expect(
          result,
          equals(Left(ConnectionFailure(
              'Unexpected error: Exception: Unexpected error'))));
    });
  });

  group('Top Rated Movies', () {
    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedMovies())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getTopRatedMovies();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedMovies())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedMovies();
      // assert
      expect(result, Left(ServerFailure('Server error occurred')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedMovies())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedMovies();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });

    test(
        'should return connection failure when the call to remote data source throws http.ClientException',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedMovies())
          .thenThrow(http.ClientException('Network connection problem'));
      // act
      final result = await repository.getTopRatedMovies();
      // assert
      expect(result,
          equals(Left(ConnectionFailure('Network connection problem'))));
    });

    test(
        'should return connection failure when the call to remote data source throws ConnectionFailureException',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedMovies())
          .thenThrow(ConnectionFailureException('Connection failure'));
      // act
      final result = await repository.getTopRatedMovies();
      // assert
      expect(result, equals(Left(ConnectionFailure('Connection failure'))));
    });

    test(
        'should return connection failure when the call to remote data source throws unexpected exception',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedMovies())
          .thenThrow(Exception('Unexpected error'));
      // act
      final result = await repository.getTopRatedMovies();
      // assert
      expect(
          result,
          equals(Left(ConnectionFailure(
              'Unexpected error: Exception: Unexpected error'))));
    });
  });

  group('Get Movie Detail', () {
    final tId = 1;
    final tMovieResponse = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 100,
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      imdbId: 'imdb1',
      originalLanguage: 'en',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 12000,
      runtime: 120,
      status: 'Status',
      tagline: 'Tagline',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return Movie data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieDetail(tId))
          .thenAnswer((_) async => tMovieResponse);
      // act
      final result = await repository.getMovieDetail(tId);
      // assert
      verify(mockRemoteDataSource.getMovieDetail(tId));
      expect(result, equals(Right(tMovieResponse.toEntity())));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getMovieDetail(tId);
      // assert
      verify(mockRemoteDataSource.getMovieDetail(tId));
      expect(result, equals(Left(ServerFailure('Server error occurred'))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getMovieDetail(tId);
      // assert
      verify(mockRemoteDataSource.getMovieDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test(
        'should return connection failure when the call to remote data source throws http.ClientException',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieDetail(tId))
          .thenThrow(http.ClientException('Network connection problem'));
      // act
      final result = await repository.getMovieDetail(tId);
      // assert
      verify(mockRemoteDataSource.getMovieDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Network connection problem'))));
    });

    test(
        'should return connection failure when the call to remote data source throws ConnectionFailureException',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieDetail(tId))
          .thenThrow(ConnectionFailureException('Connection failure'));
      // act
      final result = await repository.getMovieDetail(tId);
      // assert
      verify(mockRemoteDataSource.getMovieDetail(tId));
      expect(result, equals(Left(ConnectionFailure('Connection failure'))));
    });

    test(
        'should return connection failure when the call to remote data source throws unexpected exception',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieDetail(tId))
          .thenThrow(Exception('Unexpected error'));
      // act
      final result = await repository.getMovieDetail(tId);
      // assert
      verify(mockRemoteDataSource.getMovieDetail(tId));
      expect(
          result,
          equals(Left(ConnectionFailure(
              'Unexpected error: Exception: Unexpected error'))));
    });
  });

  group('Get Movie Recommendations', () {
    final tId = 1;

    test('should return data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getMovieRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getMovieRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      expect(result, equals(Left(ServerFailure('Server error occurred'))));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getMovieRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test(
        'should return connection failure when the call to remote data source throws http.ClientException',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenThrow(http.ClientException('Network connection problem'));
      // act
      final result = await repository.getMovieRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Network connection problem'))));
    });

    test(
        'should return connection failure when the call to remote data source throws ConnectionFailureException',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenThrow(ConnectionFailureException('Connection failure'));
      // act
      final result = await repository.getMovieRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      expect(result, equals(Left(ConnectionFailure('Connection failure'))));
    });

    test(
        'should return connection failure when the call to remote data source throws unexpected exception',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenThrow(Exception('Unexpected error'));
      // act
      final result = await repository.getMovieRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      expect(
          result,
          equals(Left(ConnectionFailure(
              'Unexpected error: Exception: Unexpected error'))));
    });
  });

  group('Search Movies', () {
    final tQuery = 'spiderman';

    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.searchMovies(tQuery);
      // assert
      verify(mockRemoteDataSource.searchMovies(tQuery));
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchMovies(tQuery);
      // assert
      verify(mockRemoteDataSource.searchMovies(tQuery));
      expect(result, Left(ServerFailure('Server error occurred')));
    });

    test(
        'should return ConnectionFailure when device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchMovies(tQuery);
      // assert
      verify(mockRemoteDataSource.searchMovies(tQuery));
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });

    test(
        'should return connection failure when the call to remote data source throws http.ClientException',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenThrow(http.ClientException('Network connection problem'));
      // act
      final result = await repository.searchMovies(tQuery);
      // assert
      verify(mockRemoteDataSource.searchMovies(tQuery));
      expect(result,
          equals(Left(ConnectionFailure('Network connection problem'))));
    });

    test(
        'should return connection failure when the call to remote data source throws ConnectionFailureException',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenThrow(ConnectionFailureException('Connection failure'));
      // act
      final result = await repository.searchMovies(tQuery);
      // assert
      verify(mockRemoteDataSource.searchMovies(tQuery));
      expect(result, equals(Left(ConnectionFailure('Connection failure'))));
    });

    test(
        'should return connection failure when the call to remote data source throws unexpected exception',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenThrow(Exception('Unexpected error'));
      // act
      final result = await repository.searchMovies(tQuery);
      // assert
      verify(mockRemoteDataSource.searchMovies(tQuery));
      expect(
          result,
          equals(Left(ConnectionFailure(
              'Unexpected error: Exception: Unexpected error'))));
    });
  });

  group('Save Watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testMovieDetail);
      // assert
      verify(mockLocalDataSource.insertWatchlist(testMovieTable));
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testMovieDetail);
      // assert
      verify(mockLocalDataSource.insertWatchlist(testMovieTable));
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });

    test(
        'should return DatabaseFailure when saving throws unexpected exception',
        () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testMovieTable))
          .thenThrow(Exception('Unexpected error'));
      // act
      final result = await repository.saveWatchlist(testMovieDetail);
      // assert
      verify(mockLocalDataSource.insertWatchlist(testMovieTable));
      expect(result, Left(DatabaseFailure('Exception: Unexpected error')));
    });
  });

  group('Remove Watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Removed from Watchlist');
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      verify(mockLocalDataSource.removeWatchlist(testMovieTable));
      expect(result, Right('Removed from Watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      verify(mockLocalDataSource.removeWatchlist(testMovieTable));
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });

    test(
        'should return DatabaseFailure when remove throws unexpected exception',
        () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTable))
          .thenThrow(Exception('Unexpected error'));
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      verify(mockLocalDataSource.removeWatchlist(testMovieTable));
      expect(result, Left(DatabaseFailure('Exception: Unexpected error')));
    });
  });

  group('Get Watchlist Status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      verify(mockLocalDataSource.getMovieById(tId));
      expect(result, false);
    });

    test('should return watch status true when data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getMovieById(tId))
          .thenAnswer((_) async => testMovieTable);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      verify(mockLocalDataSource.getMovieById(tId));
      expect(result, true);
    });
  });

  group('Get Watchlist Movies', () {
    test('should return list of Movies', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieTable]);
      // act
      final result = await repository.getWatchlistMovies();
      // assert
      verify(mockLocalDataSource.getWatchlistMovies());
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistMovie]);
    });

    test('should return DatabaseFailure when call to database is unsuccessful',
        () async {
      // arrange
      when(mockLocalDataSource.getWatchlistMovies())
          .thenThrow(DatabaseException('Failed to get watchlist'));
      // act
      final result = await repository.getWatchlistMovies();
      // assert
      verify(mockLocalDataSource.getWatchlistMovies());
      expect(result, Left(DatabaseFailure('Failed to get watchlist')));
    });

    test(
        'should return DatabaseFailure when call to database throws unexpected exception',
        () async {
      // arrange
      when(mockLocalDataSource.getWatchlistMovies())
          .thenThrow(Exception('Unexpected error'));
      // act
      final result = await repository.getWatchlistMovies();
      // assert
      verify(mockLocalDataSource.getWatchlistMovies());
      expect(result, Left(DatabaseFailure('Exception: Unexpected error')));
    });
  });
}
