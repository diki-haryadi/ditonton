import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/foundation.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetWatchListStatusTvSeries getWatchListStatus;
  final SaveWatchlistTvSeries saveWatchlist;
  final RemoveWatchlistTvSeries removeWatchlist;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  late TvSeriesDetail _tvSeries;
  TvSeriesDetail get tvSeries => _tvSeries;

  RequestState _tvSeriesState = RequestState.Empty;
  RequestState get tvSeriesState => _tvSeriesState;

  List<TvSeries> _tvSeriesRecommendations = [];
  List<TvSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getTvSeriesRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _tvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (series) {
        _recommendationState = RequestState.Loading;
        _tvSeries = series;
        notifyListeners();

        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (series) {
            _recommendationState = RequestState.Loaded;
            _tvSeriesRecommendations = series;
          },
        );

        _tvSeriesState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> addWatchlist(TvSeriesDetail series) async {
    final result = await saveWatchlist.execute(series);

    result.fold(
      (failure) {
        _watchlistMessage = failure.message;
      },
      (successMessage) {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(series.id);
  }

  Future<void> removeFromWatchlist(TvSeriesDetail series) async {
    final result = await removeWatchlist.execute(series);

    result.fold(
      (failure) {
        _watchlistMessage = failure.message;
      },
      (successMessage) {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(series.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
