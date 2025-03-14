import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_event.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries, GetPopularTvSeries, GetTopRatedTvSeries])
void main() {
  late TvSeriesListBloc tvSeriesListBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    tvSeriesListBloc = TvSeriesListBloc(
      getNowPlayingTvSeries: mockGetNowPlayingTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    );
  });

  final tTvSeries = TvSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['US'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );
  
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Now Playing TV Series', () {
    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
      expect: () => [
        TvSeriesListState.initial().copyWith(nowPlayingState: RequestState.Loading),
        TvSeriesListState.initial().copyWith(
          nowPlayingState: RequestState.Loaded,
          nowPlayingTvSeries: tTvSeriesList,
        ),
      ],
      verify: (_) {
        verify(mockGetNowPlayingTvSeries.execute());
      },
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
      expect: () => [
        TvSeriesListState.initial().copyWith(nowPlayingState: RequestState.Loading),
        TvSeriesListState.initial().copyWith(
          nowPlayingState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
      verify: (_) {
        verify(mockGetNowPlayingTvSeries.execute());
      },
    );
  });

  group('Popular TV Series', () {
    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      expect: () => [
        TvSeriesListState.initial().copyWith(popularTvSeriesState: RequestState.Loading),
        TvSeriesListState.initial().copyWith(
          popularTvSeriesState: RequestState.Loaded,
          popularTvSeries: tTvSeriesList,
        ),
      ],
      verify: (_) {
        verify(mockGetPopularTvSeries.execute());
      },
    );
  });
}