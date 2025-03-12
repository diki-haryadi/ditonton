import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class WatchlistMovieState extends Equatable {
  final RequestState watchlistState;
  final List<Movie> watchlistMovies;
  final String message;

  const WatchlistMovieState({
    required this.watchlistState,
    required this.watchlistMovies,
    required this.message,
  });

  factory WatchlistMovieState.initial() {
    return const WatchlistMovieState(
      watchlistState: RequestState.Empty,
      watchlistMovies: [],
      message: '',
    );
  }

  WatchlistMovieState copyWith({
    RequestState? watchlistState,
    List<Movie>? watchlistMovies,
    String? message,
  }) {
    return WatchlistMovieState(
      watchlistState: watchlistState ?? this.watchlistState,
      watchlistMovies: watchlistMovies ?? this.watchlistMovies,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [watchlistState, watchlistMovies, message];
}