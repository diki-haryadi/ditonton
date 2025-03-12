import 'package:bloc/bloc.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_event.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovieListState.initial()) {
    on<FetchNowPlayingMovies>(_onFetchNowPlayingMovies);
    on<FetchPopularMovies>(_onFetchPopularMovies);
    on<FetchTopRatedMovies>(_onFetchTopRatedMovies);
  }

  Future<void> _onFetchNowPlayingMovies(
    FetchNowPlayingMovies event,
    Emitter<MovieListState> emit,
  ) async {
    emit(state.copyWith(nowPlayingState: RequestState.Loading));

    try {
      final result = await getNowPlayingMovies.execute();
      result.fold(
        (failure) {
          final message = _mapFailureToMessage(failure);
          emit(state.copyWith(
            nowPlayingState: RequestState.Error,
            message: message,
          ));
        },
        (movies) {
          emit(state.copyWith(
            nowPlayingState: RequestState.Loaded,
            nowPlayingMovies: movies,
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

  Future<void> _onFetchPopularMovies(
    FetchPopularMovies event,
    Emitter<MovieListState> emit,
  ) async {
    emit(state.copyWith(popularMoviesState: RequestState.Loading));

    try {
      final result = await getPopularMovies.execute();
      result.fold(
        (failure) {
          final message = _mapFailureToMessage(failure);
          emit(state.copyWith(
            popularMoviesState: RequestState.Error,
            message: message,
          ));
        },
        (movies) {
          emit(state.copyWith(
            popularMoviesState: RequestState.Loaded,
            popularMovies: movies,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        popularMoviesState: RequestState.Error,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onFetchTopRatedMovies(
    FetchTopRatedMovies event,
    Emitter<MovieListState> emit,
  ) async {
    emit(state.copyWith(topRatedMoviesState: RequestState.Loading));

    try {
      final result = await getTopRatedMovies.execute();
      result.fold(
        (failure) {
          final message = _mapFailureToMessage(failure);
          emit(state.copyWith(
            topRatedMoviesState: RequestState.Error,
            message: message,
          ));
        },
        (movies) {
          emit(state.copyWith(
            topRatedMoviesState: RequestState.Loaded,
            topRatedMovies: movies,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        topRatedMoviesState: RequestState.Error,
        message: e.toString(),
      ));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ConnectionFailure) {
      return 'Failed to connect to the network';
    } else if (failure is ServerFailure) {
      return 'Failed to connect to the server';
    } else {
      return 'Unexpected error';
    }
  }
}