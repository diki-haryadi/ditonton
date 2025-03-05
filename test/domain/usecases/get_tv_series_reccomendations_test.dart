import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_tv_series_reccomendations_test.mocks.dart';

@GenerateMocks([TvSeriesRepository])
void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockTvSeriesRepository);
  });

  const tId = 1;

  final tTvSeries = TvSeries(
    backdropPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'Test Series',
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Test Series Original',
    overview: 'This is a test overview',
    popularity: 1000.0,
    posterPath: '/poster.jpg',
    voteAverage: 8.5,
    voteCount: 1000,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('GetTvSeriesRecommendations', () {
    test('should get list of TV series recommendations from the repository',
        () async {
      // arrange
      when(mockTvSeriesRepository.getTvSeriesRecommendations(tId))
          .thenAnswer((_) async => Right(tTvSeriesList));

      // act
      final result = await usecase.execute(tId);

      // assert
      expect(result, Right(tTvSeriesList));
      verify(mockTvSeriesRepository.getTvSeriesRecommendations(tId));
      verifyNoMoreInteractions(mockTvSeriesRepository);
    });

    test('should return server failure when repository request fails',
        () async {
      // arrange
      when(mockTvSeriesRepository.getTvSeriesRecommendations(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server error')));

      // act
      final result = await usecase.execute(tId);

      // assert
      expect(result, Left(ServerFailure('Server error')));
      verify(mockTvSeriesRepository.getTvSeriesRecommendations(tId));
      verifyNoMoreInteractions(mockTvSeriesRepository);
    });

    test('should return connection failure when device is offline', () async {
      // arrange
      when(mockTvSeriesRepository.getTvSeriesRecommendations(tId)).thenAnswer(
          (_) async => Left(ConnectionFailure('No internet connection')));

      // act
      final result = await usecase.execute(tId);

      // assert
      expect(result, Left(ConnectionFailure('No internet connection')));
      verify(mockTvSeriesRepository.getTvSeriesRecommendations(tId));
      verifyNoMoreInteractions(mockTvSeriesRepository);
    });

    test('should return empty list when successful but no recommendations',
        () async {
      // arrange
      when(mockTvSeriesRepository.getTvSeriesRecommendations(tId))
          .thenAnswer((_) async => const Right(<TvSeries>[]));

      // act
      final result = await usecase.execute(tId);

      // assert
      expect(result, const Right(<TvSeries>[]));
      verify(mockTvSeriesRepository.getTvSeriesRecommendations(tId));
      verifyNoMoreInteractions(mockTvSeriesRepository);
    });
  });
}
