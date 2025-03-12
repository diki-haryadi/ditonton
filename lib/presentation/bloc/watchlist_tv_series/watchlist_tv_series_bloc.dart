import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_event.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvSeriesBloc({required this.getWatchlistTvSeries})
      : super(WatchlistTvSeriesState.initial()) {
    on<FetchWatchlistTvSeries>(_onFetchWatchlistTvSeries);
  }

  Future<void> _onFetchWatchlistTvSeries(
    FetchWatchlistTvSeries event,
    Emitter<WatchlistTvSeriesState> emit,
  ) async {
    emit(state.copyWith(watchlistState: RequestState.Loading));

    final result = await getWatchlistTvSeries.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          watchlistState: RequestState.Error,
          message: failure.message,
        ));
      },
      (seriesData) {
        emit(state.copyWith(
          watchlistState: RequestState.Loaded,
          watchlistTvSeries: seriesData,
        ));
      },
    );
  }
}