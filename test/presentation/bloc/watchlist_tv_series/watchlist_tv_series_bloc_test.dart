import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_event.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(
      getWatchlistTvSeries: mockGetWatchlistTvSeries,
    );
  });

  test('initial state should be empty', () {
    expect(watchlistTvSeriesBloc.state, WatchlistTvSeriesState.initial());
  });

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right([testWatchlistTvSeries]));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    expect: () => [
      WatchlistTvSeriesState.initial()
          .copyWith(watchlistState: RequestState.Loading),
      WatchlistTvSeriesState.initial().copyWith(
        watchlistState: RequestState.Loaded,
        watchlistTvSeries: [testWatchlistTvSeries],
      ),
    ],
    verify: (_) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'should emit [Loading, Error] when get watchlist is unsuccessful',
    build: () {
      when(mockGetWatchlistTvSeries.execute()).thenAnswer(
          (_) async => Left(DatabaseFailure("Can't get watchlist")));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    expect: () => [
      WatchlistTvSeriesState.initial()
          .copyWith(watchlistState: RequestState.Loading),
      WatchlistTvSeriesState.initial().copyWith(
        watchlistState: RequestState.Error,
        message: "Can't get watchlist",
      ),
    ],
    verify: (_) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );
}
