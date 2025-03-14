import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_event.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc({required this.getWatchlistMovies})
      : super(WatchlistMovieState.initial()) {
    on<FetchWatchlistMovies>(_onFetchWatchlistMovies);
  }

  Future<void> _onFetchWatchlistMovies(
    FetchWatchlistMovies event,
    Emitter<WatchlistMovieState> emit,
  ) async {
    emit(state.copyWith(watchlistState: RequestState.Loading));

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          watchlistState: RequestState.Error,
          message: failure.message,
        ));
      },
      (moviesData) {
        emit(state.copyWith(
          watchlistState: RequestState.Loaded,
          watchlistMovies: moviesData,
        ));
      },
    );
  }
}
