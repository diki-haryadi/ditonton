import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_event.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetWatchListStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetWatchListStatusTvSeries mockGetWatchlistStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlist;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlist;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatusTvSeries();
    mockSaveWatchlist = MockSaveWatchlistTvSeries();
    mockRemoveWatchlist = MockRemoveWatchlistTvSeries();
    tvSeriesDetailBloc = TvSeriesDetailBloc(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;
  final tTvSeries = <TvSeries>[];

  void arrangeUsecasesSuccess() {
    when(mockGetTvSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    when(mockGetTvSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvSeries));
  }

  group('Get TV Series Detail', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emit [Loading, Loaded] when tv series detail data is gotten successfully',
      build: () {
        arrangeUsecasesSuccess();
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvSeriesDetail(tId)),
      expect: () => [
        TvSeriesDetailState.initial()
            .copyWith(tvSeriesState: RequestState.Loading),
        TvSeriesDetailState.initial().copyWith(
          tvSeriesState: RequestState.Loaded,
          tvSeriesDetail: testTvSeriesDetail,
          recommendationState: RequestState.Loading,
        ),
        TvSeriesDetailState.initial().copyWith(
          tvSeriesState: RequestState.Loaded,
          tvSeriesDetail: testTvSeriesDetail,
          recommendationState: RequestState.Loaded,
          recommendations: tTvSeries,
        ),
      ],
      verify: (_) {
        verify(mockGetTvSeriesDetail.execute(tId));
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emit [Loading, Error] when get tv series detail is unsuccessful',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetTvSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvSeries));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvSeriesDetail(tId)),
      expect: () => [
        TvSeriesDetailState.initial()
            .copyWith(tvSeriesState: RequestState.Loading),
        TvSeriesDetailState.initial().copyWith(
          tvSeriesState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
      verify: (_) {
        verify(mockGetTvSeriesDetail.execute(tId));
      },
    );
  });

  group('Add Watchlist', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emit [Loading, Loaded] and watchlist message when add watchlist is successful',
      build: () {
        when(mockSaveWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(AddTvSeriesToWatchlist(testTvSeriesDetail)),
      expect: () => [
        TvSeriesDetailState.initial().copyWith(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testTvSeriesDetail));
        verify(mockGetWatchlistStatus.execute(testTvSeriesDetail.id));
      },
    );
  });
}
