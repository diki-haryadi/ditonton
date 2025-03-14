import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailState.initial()) {
    on<FetchMovieDetail>(_onFetchMovieDetail);
    on<AddMovieToWatchlist>(_onAddMovieToWatchlist);
    on<RemoveMovieFromWatchlist>(_onRemoveMovieFromWatchlist);
    on<LoadWatchlistStatus>(_onLoadWatchlistStatus);
  }

  Future<void> _onFetchMovieDetail(
    FetchMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(state.copyWith(movieState: RequestState.Loading));

    final detailResult = await getMovieDetail.execute(event.id);

    if (detailResult.isLeft()) {
      final failure = detailResult.fold(
        (l) => l,
        (r) => null,
      );
      emit(state.copyWith(
        movieState: RequestState.Error,
        message: failure!.message,
      ));
      return;
    }

    final movie = detailResult.fold(
      (l) => null,
      (r) => r,
    );

    emit(state.copyWith(
      movieState: RequestState.Loaded,
      movieDetail: movie,
      recommendationState: RequestState.Loading,
    ));

    final recommendationResult =
        await getMovieRecommendations.execute(event.id);

    if (recommendationResult.isLeft()) {
      final failure = recommendationResult.fold(
        (l) => l,
        (r) => null,
      );
      emit(state.copyWith(
        recommendationState: RequestState.Error,
        message: failure!.message,
      ));
    } else {
      final recommendations = recommendationResult.fold(
        (l) => <Movie>[], // Explicitly typed empty list
        (r) => r,
      );
      emit(state.copyWith(
        recommendationState: RequestState.Loaded,
        recommendations: recommendations,
      ));
    }
  }

  Future<void> _onAddMovieToWatchlist(
    AddMovieToWatchlist event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await saveWatchlist.execute(event.movieDetail);

    String message = watchlistAddSuccessMessage;
    result.fold(
      (failure) {
        message = failure.message;
      },
      (successMessage) {
        message = successMessage;
      },
    );

    // Update watchlist status
    final status = await getWatchListStatus.execute(event.movieDetail.id);
    emit(state.copyWith(
      watchlistMessage: message,
      isAddedToWatchlist: status,
    ));
  }

  Future<void> _onRemoveMovieFromWatchlist(
    RemoveMovieFromWatchlist event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await removeWatchlist.execute(event.movieDetail);

    String message = '';
    result.fold(
      (failure) {
        message = failure.message;
      },
      (successMessage) {
        message = successMessage;
      },
    );
    print(message);
    // Update watchlist status
    final status = await getWatchListStatus.execute(event.movieDetail.id);
    emit(state.copyWith(
      watchlistMessage: message,
      isAddedToWatchlist: status,
    ));
  }

  Future<void> _onLoadWatchlistStatus(
    LoadWatchlistStatus event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await getWatchListStatus.execute(event.id);
    emit(state.copyWith(isAddedToWatchlist: result));
  }
}
