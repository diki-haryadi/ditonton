import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_watchlist_tv_series_test.mocks.dart';

@GenerateMocks([TvSeriesRepository])
void main() {
  late SaveWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SaveWatchlistTvSeries(mockTvSeriesRepository);
  });

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

  const successMessage = 'Added to Watchlist';

  group('SaveWatchlistTvSeries', () {
    test('should save tv series to watchlist through repository', () async {
      // arrange
      when(mockTvSeriesRepository.saveWatchlist(tTvSeriesDetail))
          .thenAnswer((_) async => const Right(successMessage));

      // act
      final result = await usecase.execute(tTvSeriesDetail);

      // assert
      expect(result, const Right(successMessage));
      verify(mockTvSeriesRepository.saveWatchlist(tTvSeriesDetail));
      verifyNoMoreInteractions(mockTvSeriesRepository);
    });

    test('should return database failure when save to watchlist fails',
        () async {
      // arrange
      when(mockTvSeriesRepository.saveWatchlist(tTvSeriesDetail)).thenAnswer(
          (_) async => Left(DatabaseFailure('Failed to add to watchlist')));

      // act
      final result = await usecase.execute(tTvSeriesDetail);

      // assert
      expect(result, Left(DatabaseFailure('Failed to add to watchlist')));
      verify(mockTvSeriesRepository.saveWatchlist(tTvSeriesDetail));
      verifyNoMoreInteractions(mockTvSeriesRepository);
    });

    test('should pass through any other failure from repository', () async {
      // arrange
      when(mockTvSeriesRepository.saveWatchlist(tTvSeriesDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server error')));

      // act
      final result = await usecase.execute(tTvSeriesDetail);

      // assert
      expect(result, Left(ServerFailure('Server error')));
      verify(mockTvSeriesRepository.saveWatchlist(tTvSeriesDetail));
      verifyNoMoreInteractions(mockTvSeriesRepository);
    });
  });
}
