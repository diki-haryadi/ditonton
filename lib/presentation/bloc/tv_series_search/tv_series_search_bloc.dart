import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_search/tv_series_search_event.dart';
import 'package:ditonton/presentation/bloc/tv_series_search/tv_series_search_state.dart';

class TvSeriesSearchBloc extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  final SearchTvSeries searchTvSeries;

  TvSeriesSearchBloc({required this.searchTvSeries})
      : super(TvSeriesSearchState.initial()) {
    on<QueryChanged>(_onQueryChanged);
  }

  Future<void> _onQueryChanged(
    QueryChanged event,
    Emitter<TvSeriesSearchState> emit,
  ) async {
    final query = event.query;

    if (query.isEmpty) {
      emit(TvSeriesSearchState.initial());
      return;
    }

    emit(state.copyWith(state: RequestState.Loading));

    final result = await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        emit(state.copyWith(
          state: RequestState.Error,
          message: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          state: RequestState.Loaded,
          searchResult: data,
        ));
      },
    );
  }
}