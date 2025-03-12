import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class WatchlistTvSeriesState extends Equatable {
  final RequestState watchlistState;
  final List<TvSeries> watchlistTvSeries;
  final String message;

  const WatchlistTvSeriesState({
    required this.watchlistState,
    required this.watchlistTvSeries,
    required this.message,
  });

  factory WatchlistTvSeriesState.initial() {
    return const WatchlistTvSeriesState(
      watchlistState: RequestState.Empty,
      watchlistTvSeries: [],
      message: '',
    );
  }

  WatchlistTvSeriesState copyWith({
    RequestState? watchlistState,
    List<TvSeries>? watchlistTvSeries,
    String? message,
  }) {
    return WatchlistTvSeriesState(
      watchlistState: watchlistState ?? this.watchlistState,
      watchlistTvSeries: watchlistTvSeries ?? this.watchlistTvSeries,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [watchlistState, watchlistTvSeries, message];
}
