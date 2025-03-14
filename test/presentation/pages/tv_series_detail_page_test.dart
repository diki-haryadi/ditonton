import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_state.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';

import 'tv_series_detail_page_test.mocks.dart';

@GenerateMocks([TvSeriesDetailBloc])
void main() {
  late MockTvSeriesDetailBloc mockBloc;

  setUp(() {
    mockBloc = MockTvSeriesDetailBloc();
    when(mockBloc.stream).thenAnswer((_) => Stream.value(TvSeriesDetailState.initial()));
    when(mockBloc.state).thenReturn(TvSeriesDetailState.initial());
    when(mockBloc.add(any)).thenReturn(null);
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
        routes: {
          TvSeriesDetailPage.ROUTE_NAME: (context) => TvSeriesDetailPage(id: 1),
        },
      ),
    );
  }

  final tId = 1;

  final tTvSeries = TvSeries(
    backdropPath: 'path/to/backdrop.jpg',
    genreIds: [1, 2],
    id: 1,
    name: 'Test Series',
    overview: 'Test Overview',
    posterPath: 'path/to/poster.jpg',
    firstAirDate: '2023-01-01',
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Original Test Series',
    popularity: 8.5,
    voteAverage: 8.5,
    voteCount: 100,
  );

  final tTvSeriesDetail = TvSeriesDetail(
    backdropPath: 'path/to/backdrop.jpg',
    episodeRunTime: [60],
    firstAirDate: '2023-01-01',
    genres: [Genre(id: 1, name: 'Action'), Genre(id: 2, name: 'Drama')],
    homepage: 'https://example.com',
    id: 1,
    inProduction: true,
    lastAirDate: '2023-12-31',
    name: 'Test Series',
    numberOfEpisodes: 12,
    numberOfSeasons: 1,
    originalLanguage: 'en',
    originalName: 'Original Test Series',
    overview: 'Test Overview',
    popularity: 8.5,
    posterPath: 'path/to/poster.jpg',
    status: 'Returning Series',
    tagline: 'A test tagline',
    type: 'Scripted',
    voteAverage: 8.5,
    voteCount: 100
  );

  testWidgets('Page should display loading indicator when state is loading',
      (WidgetTester tester) async {
    // arrange
    when(mockBloc.stream).thenAnswer((_) => Stream.fromIterable([
      TvSeriesDetailState.initial().copyWith(
        tvSeriesState: RequestState.Loading,
      ),
    ]));

    // act
    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));

    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    verify(mockBloc.add(FetchTvSeriesDetail(tId))).called(1);
  });

  testWidgets('Page should display error message when state is error',
      (WidgetTester tester) async {
    // arrange
    when(mockBloc.stream).thenAnswer((_) => Stream.fromIterable([
      TvSeriesDetailState.initial().copyWith(
        tvSeriesState: RequestState.Error,
        message: 'Error message',
      ),
    ]));

    // act
    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));

    // assert
    expect(find.text('Error message'), findsOneWidget);
    verify(mockBloc.add(FetchTvSeriesDetail(tId))).called(1);
  });

  testWidgets('Page should display tv series detail when state is loaded',
      (WidgetTester tester) async {
    // arrange
    when(mockBloc.stream).thenAnswer((_) => Stream.fromIterable([
      TvSeriesDetailState.initial().copyWith(
        tvSeriesState: RequestState.Loaded,
        tvSeriesDetail: tTvSeriesDetail,
        recommendations: [tTvSeries],
        recommendationState: RequestState.Loaded,
        isAddedToWatchlist: false,
      ),
    ]));

    // act
    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));

    // assert
    verify(mockBloc.add(FetchTvSeriesDetail(tId))).called(1);
    expect(find.text('Test Series'), findsOneWidget);
    expect(find.text('Action, Drama'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Test Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
    expect(find.byType(CachedNetworkImage),
        findsNWidgets(2)); // One for poster, one for recommendation
  });

  testWidgets(
      'Page should display empty genres when tv series detail has no genres',
      (WidgetTester tester) async {
    // arrange
    final emptyGenreTvSeriesDetail = TvSeriesDetail(
      backdropPath: 'path/to/backdrop.jpg',
      episodeRunTime: [60],
      firstAirDate: '2023-01-01',
      genres: [],
      homepage: 'https://example.com',
      id: 1,
      inProduction: true,
      lastAirDate: '2023-12-31',
      name: 'Test Series',
      numberOfEpisodes: 12,
      numberOfSeasons: 1,
      originalLanguage: 'en',
      originalName: 'Original Test Series',
      overview: 'Test Overview',
      popularity: 8.5,
      posterPath: 'path/to/poster.jpg',
      status: 'Returning Series',
      tagline: 'A test tagline',
      type: 'Scripted',
      voteAverage: 8.5,
      voteCount: 100
    );

    when(mockBloc.state).thenReturn(
      TvSeriesDetailState.initial().copyWith(
        tvSeriesState: RequestState.Loaded,
        tvSeriesDetail: emptyGenreTvSeriesDetail,
        recommendations: [tTvSeries],
        isAddedToWatchlist: false,
      ),
    );

    // act
    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));

    // assert
    verify(mockBloc.add(FetchTvSeriesDetail(tId))).called(1);
    expect(find.text('Action'), findsNothing);
    expect(find.text('Drama'), findsNothing);
    expect(find.text('Action, Drama'), findsNothing);
  });
}
