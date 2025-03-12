import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class MovieListState extends Equatable {
  final RequestState nowPlayingState;
  final RequestState popularMoviesState;
  final RequestState topRatedMoviesState;
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;
  final String message;

  const MovieListState({
    required this.nowPlayingState,
    required this.popularMoviesState,
    required this.topRatedMoviesState,
    required this.nowPlayingMovies,
    required this.popularMovies,
    required this.topRatedMovies,
    required this.message,
  });

  factory MovieListState.initial() {
    return MovieListState(
      nowPlayingState: RequestState.Empty,
      popularMoviesState: RequestState.Empty,
      topRatedMoviesState: RequestState.Empty,
      nowPlayingMovies: [],
      popularMovies: [],
      topRatedMovies: [],
      message: '',
    );
  }

  MovieListState copyWith({
    RequestState? nowPlayingState,
    RequestState? popularMoviesState,
    RequestState? topRatedMoviesState,
    List<Movie>? nowPlayingMovies,
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
    String? message,
  }) {
    return MovieListState(
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      popularMoviesState: popularMoviesState ?? this.popularMoviesState,
      topRatedMoviesState: topRatedMoviesState ?? this.topRatedMoviesState,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        nowPlayingState,
        popularMoviesState,
        topRatedMoviesState,
        nowPlayingMovies,
        popularMovies,
        topRatedMovies,
        message,
      ];
}