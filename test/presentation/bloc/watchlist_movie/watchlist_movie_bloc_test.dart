import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_event.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
    );
  });

  test('initial state should be empty', () {
    expect(watchlistMovieBloc.state, WatchlistMovieState.initial());
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    expect: () => [
      WatchlistMovieState.initial().copyWith(watchlistState: RequestState.Loading),
      WatchlistMovieState.initial().copyWith(
        watchlistState: RequestState.Loaded,
        watchlistMovies: [testWatchlistMovie],
      ),
    ],
    verify: (_) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should emit [Loading, Error] when get watchlist is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get watchlist")));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    expect: () => [
      WatchlistMovieState.initial().copyWith(watchlistState: RequestState.Loading),
      WatchlistMovieState.initial().copyWith(
        watchlistState: RequestState.Error,
        message: "Can't get watchlist",
      ),
    ],
    verify: (_) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}