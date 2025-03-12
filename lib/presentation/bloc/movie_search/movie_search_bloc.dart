import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_event.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc({required this.searchMovies}) : super(MovieSearchState.initial()) {
    on<QueryChanged>(_onQueryChanged);
  }

  Future<void> _onQueryChanged(
    QueryChanged event,
    Emitter<MovieSearchState> emit,
  ) async {
    final query = event.query;

    if (query.isEmpty) {
      emit(MovieSearchState.initial());
      return;
    }

    emit(state.copyWith(state: RequestState.Loading));

    final result = await searchMovies.execute(query);
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