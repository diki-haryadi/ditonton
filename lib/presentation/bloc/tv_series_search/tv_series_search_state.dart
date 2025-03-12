import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TvSeriesSearchState extends Equatable {
  final RequestState state;
  final List<TvSeries> searchResult;
  final String message;

  const TvSeriesSearchState({
    required this.state,
    required this.searchResult,
    required this.message,
  });

  factory TvSeriesSearchState.initial() {
    return const TvSeriesSearchState(
      state: RequestState.Empty,
      searchResult: [],
      message: '',
    );
  }

  TvSeriesSearchState copyWith({
    RequestState? state,
    List<TvSeries>? searchResult,
    String? message,
  }) {
    return TvSeriesSearchState(
      state: state ?? this.state,
      searchResult: searchResult ?? this.searchResult,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [state, searchResult, message];
}
