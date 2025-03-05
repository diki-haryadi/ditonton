import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_tv_series_detail_test.mocks.dart';

@GenerateMocks([TvSeriesRepository])
void main() {
  late GetTvSeriesDetail usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesDetail(mockTvSeriesRepository);
  });

  const tId = 1;

  final tTvSeriesDetail = TvSeriesDetail(
    backdropPath: 'backdropPath',
    episodeRunTime: [60],
    firstAirDate: '2022-01-01',
    genres: [Genre(id: 1, name: 'Action')],
    homepage: 'https://example.com',
    id: 1,
    inProduction: true,
    lastAirDate: '2022-12-31',
    name: 'Test Series',
    numberOfEpisodes: 12,
    numberOfSeasons: 1,
    originalLanguage: 'en',
    originalName: 'Test Series Original',
    overview: 'This is a test overview',
    popularity: 1000.0,
    posterPath: '/path.jpg',
    status: 'Ended',
    tagline: 'A test tagline',
    type: 'Scripted',
    voteAverage: 8.5,
    voteCount: 1000,
  );

  group('GetTvSeriesDetail', () {
    test('should get TV series detail from the repository', () async {
      // arrange
      when(mockTvSeriesRepository.getTvSeriesDetail(tId))
          .thenAnswer((_) async => Right(tTvSeriesDetail));

      // act
      final result = await usecase.execute(tId);

      // assert
      expect(result, Right(tTvSeriesDetail));
      verify(mockTvSeriesRepository.getTvSeriesDetail(tId));
      verifyNoMoreInteractions(mockTvSeriesRepository);
    });

    test('should return server failure when repository request fails',
        () async {
      // arrange
      when(mockTvSeriesRepository.getTvSeriesDetail(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server error')));

      // act
      final result = await usecase.execute(tId);

      // assert
      expect(result, Left(ServerFailure('Server error')));
      verify(mockTvSeriesRepository.getTvSeriesDetail(tId));
      verifyNoMoreInteractions(mockTvSeriesRepository);
    });

    test('should return connection failure when device is offline', () async {
      // arrange
      when(mockTvSeriesRepository.getTvSeriesDetail(tId)).thenAnswer(
          (_) async => Left(ConnectionFailure('No internet connection')));

      // act
      final result = await usecase.execute(tId);

      // assert
      expect(result, Left(ConnectionFailure('No internet connection')));
      verify(mockTvSeriesRepository.getTvSeriesDetail(tId));
      verifyNoMoreInteractions(mockTvSeriesRepository);
    });

    test('should return database failure when local database operation fails',
        () async {
      // arrange
      when(mockTvSeriesRepository.getTvSeriesDetail(tId))
          .thenAnswer((_) async => Left(DatabaseFailure('Database error')));

      // act
      final result = await usecase.execute(tId);

      // assert
      expect(result, Left(DatabaseFailure('Database error')));
      verify(mockTvSeriesRepository.getTvSeriesDetail(tId));
      verifyNoMoreInteractions(mockTvSeriesRepository);
    });
  });
}
