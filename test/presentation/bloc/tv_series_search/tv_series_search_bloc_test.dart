import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_search/tv_series_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_search/tv_series_search_event.dart';
import 'package:ditonton/presentation/bloc/tv_series_search/tv_series_search_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late TvSeriesSearchBloc tvSeriesSearchBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    tvSeriesSearchBloc = TvSeriesSearchBloc(searchTvSeries: mockSearchTvSeries);
  });

  final tTvSeriesModel = TvSeries(
    backdropPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'Name',
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1000.0,
    posterPath: '/path.jpg',
    voteAverage: 8.0,
    voteCount: 200,
  );

  final tTvSeriesList = <TvSeries>[tTvSeriesModel];
  final tQuery = 'game of thrones';

  test('initial state should be empty', () {
    expect(tvSeriesSearchBloc.state, TvSeriesSearchState.initial());
  });

  blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
    'should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      return tvSeriesSearchBloc;
    },
    act: (bloc) => bloc.add(QueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSeriesSearchState.initial().copyWith(state: RequestState.Loading),
      TvSeriesSearchState.initial().copyWith(
        state: RequestState.Loaded,
        searchResult: tTvSeriesList,
      ),
    ],
    verify: (_) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );

  blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
    'should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesSearchBloc;
    },
    act: (bloc) => bloc.add(QueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSeriesSearchState.initial().copyWith(state: RequestState.Loading),
      TvSeriesSearchState.initial().copyWith(
        state: RequestState.Error,
        message: 'Server Failure',
      ),
    ],
    verify: (_) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );
}
