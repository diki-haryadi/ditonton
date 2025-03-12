import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailState extends Equatable {
  final RequestState tvSeriesState;
  final RequestState recommendationState;
  final TvSeriesDetail? tvSeriesDetail;
  final List<TvSeries> recommendations;
  final bool isAddedToWatchlist;
  final String message;
  final String watchlistMessage;

  const TvSeriesDetailState({
    required this.tvSeriesState,
    required this.recommendationState,
    this.tvSeriesDetail,
    required this.recommendations,
    required this.isAddedToWatchlist,
    required this.message,
    required this.watchlistMessage,
  });

  factory TvSeriesDetailState.initial() {
    return const TvSeriesDetailState(
      tvSeriesState: RequestState.Empty,
      recommendationState: RequestState.Empty,
      tvSeriesDetail: null,
      recommendations: [],
      isAddedToWatchlist: false,
      message: '',
      watchlistMessage: '',
    );
  }

  TvSeriesDetailState copyWith({
    RequestState? tvSeriesState,
    RequestState? recommendationState,
    TvSeriesDetail? tvSeriesDetail,
    List<TvSeries>? recommendations,
    bool? isAddedToWatchlist,
    String? message,
    String? watchlistMessage,
  }) {
    return TvSeriesDetailState(
      tvSeriesState: tvSeriesState ?? this.tvSeriesState,
      recommendationState: recommendationState ?? this.recommendationState,
      tvSeriesDetail: tvSeriesDetail ?? this.tvSeriesDetail,
      recommendations: recommendations ?? this.recommendations,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  @override
  List<Object?> get props => [
        tvSeriesState,
        recommendationState,
        tvSeriesDetail,
        recommendations,
        isAddedToWatchlist,
        message,
        watchlistMessage,
      ];
}
