import 'package:bloc/bloc.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_event.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_state.dart';

class TvSeriesListBloc extends Bloc<TvSeriesListEvent, TvSeriesListState> {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TvSeriesListBloc({
    required this.getNowPlayingTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  }) : super(TvSeriesListState.initial()) {
    on<FetchNowPlayingTvSeries>(_onFetchNowPlayingTvSeries);
    on<FetchPopularTvSeries>(_onFetchPopularTvSeries);
    on<FetchTopRatedTvSeries>(_onFetchTopRatedTvSeries);
  }

  Future<void> _onFetchNowPlayingTvSeries(
    FetchNowPlayingTvSeries event,
    Emitter<TvSeriesListState> emit,
  ) async {
    emit(state.copyWith(nowPlayingState: RequestState.Loading));

    try {
      final result = await getNowPlayingTvSeries.execute();
      result.fold(
        (failure) {
          final message = _mapFailureToMessage(failure);
          emit(state.copyWith(
            nowPlayingState: RequestState.Error,
            message: message,
          ));
        },
        (seriesData) {
          emit(state.copyWith(
            nowPlayingState: RequestState.Loaded,
            nowPlayingTvSeries: seriesData,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        nowPlayingState: RequestState.Error,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onFetchPopularTvSeries(
    FetchPopularTvSeries event,
    Emitter<TvSeriesListState> emit,
  ) async {
    emit(state.copyWith(popularTvSeriesState: RequestState.Loading));

    try {
      final result = await getPopularTvSeries.execute();
      result.fold(
        (failure) {
          final message = _mapFailureToMessage(failure);
          emit(state.copyWith(
            popularTvSeriesState: RequestState.Error,
            message: message,
          ));
        },
        (seriesData) {
          emit(state.copyWith(
            popularTvSeriesState: RequestState.Loaded,
            popularTvSeries: seriesData,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        popularTvSeriesState: RequestState.Error,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onFetchTopRatedTvSeries(
    FetchTopRatedTvSeries event,
    Emitter<TvSeriesListState> emit,
  ) async {
    emit(state.copyWith(topRatedTvSeriesState: RequestState.Loading));

    try {
      final result = await getTopRatedTvSeries.execute();
      result.fold(
        (failure) {
          final message = _mapFailureToMessage(failure);
          emit(state.copyWith(
            topRatedTvSeriesState: RequestState.Error,
            message: message,
          ));
        },
        (seriesData) {
          emit(state.copyWith(
            topRatedTvSeriesState: RequestState.Loaded,
            topRatedTvSeries: seriesData,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        topRatedTvSeriesState: RequestState.Error,
        message: e.toString(),
      ));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ConnectionFailure) {
      return 'Failed to connect to the network';
    } else if (failure is ServerFailure) {
      return 'Server Failure';
    } else {
      return 'Unexpected error';
    }
  }
}
