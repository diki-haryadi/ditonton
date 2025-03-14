import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_event.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MovieSearchBloc movieSearchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    movieSearchBloc = MovieSearchBloc(searchMovies: mockSearchMovies);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'Original Title',
    overview: 'Overview',
    popularity: 1000.0,
    posterPath: '/path.jpg',
    releaseDate: '2022-01-01',
    title: 'Title',
    video: false,
    voteAverage: 8.0,
    voteCount: 200,
  );

  final tMovieList = <Movie>[tMovieModel];
  final tQuery = 'spiderman';

  test('initial state should be empty', () {
    expect(movieSearchBloc.state, MovieSearchState.initial());
  });

  blocTest<MovieSearchBloc, MovieSearchState>(
    'should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(QueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieSearchState.initial().copyWith(state: RequestState.Loading),
      MovieSearchState.initial().copyWith(
        state: RequestState.Loaded,
        searchResult: tMovieList,
      ),
    ],
    verify: (_) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(QueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieSearchState.initial().copyWith(state: RequestState.Loading),
      MovieSearchState.initial().copyWith(
        state: RequestState.Error,
        message: 'Server Failure',
      ),
    ],
    verify: (_) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );
}
