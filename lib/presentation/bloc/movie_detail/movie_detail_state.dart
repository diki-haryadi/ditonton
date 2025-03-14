import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class MovieDetailState extends Equatable {
  final RequestState movieState;
  final RequestState recommendationState;
  final MovieDetail? movieDetail;
  final List<Movie> recommendations;
  final bool isAddedToWatchlist;
  final String message;
  final String watchlistMessage;

  const MovieDetailState({
    required this.movieState,
    required this.recommendationState,
    this.movieDetail,
    required this.recommendations,
    required this.isAddedToWatchlist,
    required this.message,
    required this.watchlistMessage,
  });

  factory MovieDetailState.initial() {
    return const MovieDetailState(
      movieState: RequestState.Empty,
      recommendationState: RequestState.Empty,
      movieDetail: null,
      recommendations: [],
      isAddedToWatchlist: false,
      message: '',
      watchlistMessage: '',
    );
  }

  MovieDetailState copyWith({
    RequestState? movieState,
    RequestState? recommendationState,
    MovieDetail? movieDetail,
    List<Movie>? recommendations,
    bool? isAddedToWatchlist,
    String? message,
    String? watchlistMessage,
  }) {
    return MovieDetailState(
      movieState: movieState ?? this.movieState,
      recommendationState: recommendationState ?? this.recommendationState,
      movieDetail: movieDetail ?? this.movieDetail,
      recommendations: recommendations ?? this.recommendations,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  @override
  List<Object?> get props => [
        movieState,
        recommendationState,
        movieDetail,
        recommendations,
        isAddedToWatchlist,
        message,
        watchlistMessage,
      ];
}
