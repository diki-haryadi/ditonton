import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

abstract class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchTvSeriesDetail extends TvSeriesDetailEvent {
  final int id;

  const FetchTvSeriesDetail(this.id);

  @override
  List<Object> get props => [id];
}

class AddTvSeriesToWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeriesDetail;

  const AddTvSeriesToWatchlist(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class RemoveTvSeriesFromWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeriesDetail;

  const RemoveTvSeriesFromWatchlist(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class LoadTvSeriesWatchlistStatus extends TvSeriesDetailEvent {
  final int id;

  const LoadTvSeriesWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
