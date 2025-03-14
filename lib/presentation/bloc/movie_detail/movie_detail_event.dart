import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchMovieDetail extends MovieDetailEvent {
  final int id;

  const FetchMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class AddMovieToWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const AddMovieToWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveMovieFromWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const RemoveMovieFromWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class LoadWatchlistStatus extends MovieDetailEvent {
  final int id;

  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
