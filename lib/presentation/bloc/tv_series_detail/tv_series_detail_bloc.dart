import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_event.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_state.dart';

class TvSeriesDetailBloc extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetWatchListStatusTvSeries getWatchListStatus;
  final SaveWatchlistTvSeries saveWatchlist;
  final RemoveWatchlistTvSeries removeWatchlist;

  TvSeriesDetailBloc({
    required this.getTvSeriesDetail,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getTvSeriesRecommendations,
  }) : super(TvSeriesDetailState.initial()) {
    on<FetchTvSeriesDetail>(_onFetchTvSeriesDetail);
    on<AddTvSeriesToWatchlist>(_onAddTvSeriesToWatchlist);
    on<RemoveTvSeriesFromWatchlist>(_onRemoveTvSeriesFromWatchlist);
    on<LoadTvSeriesWatchlistStatus>(_onLoadTvSeriesWatchlistStatus);
  }

  Future<void> _onFetchTvSeriesDetail(
    FetchTvSeriesDetail event,
    Emitter<TvSeriesDetailState> emit,
  ) async {
    emit(state.copyWith(tvSeriesState: RequestState.Loading));

    final detailResult = await getTvSeriesDetail.execute(event.id);

    if (detailResult.isLeft()) {
      final failure = detailResult.fold(
        (l) => l,
        (r) => null,
      );
      emit(state.copyWith(
        tvSeriesState: RequestState.Error,
        message: failure!.message,
      ));
      return;
    }
    
    final tvSeries = detailResult.fold(
      (l) => null,
      (r) => r,
    );
    
    emit(state.copyWith(
      tvSeriesState: RequestState.Loaded,
      tvSeriesDetail: tvSeries,
      recommendationState: RequestState.Loading,
    ));
    
    final recommendationResult = await getTvSeriesRecommendations.execute(event.id);
    
    if (recommendationResult.isLeft()) {
      final failure = recommendationResult.fold(
        (l) => l,
        (r) => null,
      );
      emit(state.copyWith(
        recommendationState: RequestState.Error,
        message: failure!.message,
      ));
    } else {
      final recommendations = recommendationResult.fold(
        (l) => <TvSeries>[], // Explicitly typed empty list
        (r) => r,
      );
      emit(state.copyWith(
        recommendationState: RequestState.Loaded,
        recommendations: recommendations,
      ));
    }
  }

  Future<void> _onAddTvSeriesToWatchlist(
    AddTvSeriesToWatchlist event,
    Emitter<TvSeriesDetailState> emit,
  ) async {
    final result = await saveWatchlist.execute(event.tvSeriesDetail);

    String message = watchlistAddSuccessMessage;
    result.fold(
      (failure) {
        message = failure.message;
      },
      (successMessage) {
        message = successMessage;
      },
    );
    
    emit(state.copyWith(watchlistMessage: message));
    
    // Update watchlist status after adding
    final status = await getWatchListStatus.execute(event.tvSeriesDetail.id);
    emit(state.copyWith(isAddedToWatchlist: status));
  }

  Future<void> _onRemoveTvSeriesFromWatchlist(
    RemoveTvSeriesFromWatchlist event,
    Emitter<TvSeriesDetailState> emit,
  ) async {
    final result = await removeWatchlist.execute(event.tvSeriesDetail);

    String message = '';
    result.fold(
      (failure) {
        message = failure.message;
      },
      (successMessage) {
        message = successMessage;
      },
    );
    
    emit(state.copyWith(watchlistMessage: message));
    
    // Update watchlist status after removing
    final status = await getWatchListStatus.execute(event.tvSeriesDetail.id);
    emit(state.copyWith(isAddedToWatchlist: status));
  }

  Future<void> _onLoadTvSeriesWatchlistStatus(
    LoadTvSeriesWatchlistStatus event,
    Emitter<TvSeriesDetailState> emit,
  ) async {
    final result = await getWatchListStatus.execute(event.id);
    emit(state.copyWith(isAddedToWatchlist: result));
  }
}