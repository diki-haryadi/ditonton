import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'tv_series_detail_page_test.mocks.dart';

@GenerateMocks([TvSeriesDetailNotifier])
void main() {
  late MockTvSeriesDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeriesDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeriesDetailNotifier>.value(
      value: mockNotifier,
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
      voteCount: 100);

  testWidgets('Page should display loading indicator when state is loading',
      (WidgetTester tester) async {
    // arrange
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loading);

    // act
    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));

    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display error message when state is error',
      (WidgetTester tester) async {
    // arrange
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    // act
    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));

    // assert
    expect(find.text('Error message'), findsOneWidget);
  });

  testWidgets('Page should display tv series detail when state is loaded',
      (WidgetTester tester) async {
    // arrange
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(tTvSeriesDetail);
    when(mockNotifier.tvSeriesRecommendations)
        .thenReturn(<TvSeries>[tTvSeries]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    // act
    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));

    // assert
    expect(find.text('Test Series'), findsOneWidget);
    expect(find.text('Action, Drama'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Test Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
    expect(find.byType(CachedNetworkImage),
        findsNWidgets(2)); // One for poster, one for recommendation
  });

  testWidgets(
      'Page should call fetchTvSeriesDetail and loadWatchlistStatus on initState',
      (WidgetTester tester) async {
    // arrange
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loading);

    // act
    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));

    // assert
    verify(mockNotifier.fetchTvSeriesDetail(tId));
    verify(mockNotifier.loadWatchlistStatus(tId));
  });

  testWidgets(
      'Watchlist button should display add icon when series not in watchlist',
      (WidgetTester tester) async {
    // arrange
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(tTvSeriesDetail);
    when(mockNotifier.tvSeriesRecommendations)
        .thenReturn(<TvSeries>[tTvSeries]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    // act
    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));

    // assert
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when series is in watchlist',
      (WidgetTester tester) async {
    // arrange
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(tTvSeriesDetail);
    when(mockNotifier.tvSeriesRecommendations)
        .thenReturn(<TvSeries>[tTvSeries]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    // act
    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));

    // assert
    expect(find.byIcon(Icons.check), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display SnackBar when added to watchlist',
      (WidgetTester tester) async {
    // arrange
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(tTvSeriesDetail);
    when(mockNotifier.tvSeriesRecommendations)
        .thenReturn(<TvSeries>[tTvSeries]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage)
        .thenReturn(TvSeriesDetailNotifier.watchlistAddSuccessMessage);

    // act
    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // assert
    verify(mockNotifier.addWatchlist(tTvSeriesDetail));
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(TvSeriesDetailNotifier.watchlistAddSuccessMessage),
        findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display SnackBar when removed from watchlist',
      (WidgetTester tester) async {
    // arrange
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(tTvSeriesDetail);
    when(mockNotifier.tvSeriesRecommendations)
        .thenReturn(<TvSeries>[tTvSeries]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);
    when(mockNotifier.watchlistMessage)
        .thenReturn(TvSeriesDetailNotifier.watchlistRemoveSuccessMessage);

    // act
    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // assert
    verify(mockNotifier.removeFromWatchlist(tTvSeriesDetail));
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(TvSeriesDetailNotifier.watchlistRemoveSuccessMessage),
        findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    // arrange
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(tTvSeriesDetail);
    when(mockNotifier.tvSeriesRecommendations)
        .thenReturn(<TvSeries>[tTvSeries]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage)
        .thenReturn('Failed to add to watchlist');

    // act
    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // assert
    verify(mockNotifier.addWatchlist(tTvSeriesDetail));
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed to add to watchlist'), findsOneWidget);
  });

  testWidgets(
      'Recommendation should navigate to another detail page when tapped',
      (WidgetTester tester) async {
    // arrange
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(tTvSeriesDetail);
    when(mockNotifier.tvSeriesRecommendations)
        .thenReturn(<TvSeries>[tTvSeries]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    // act
    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));
    await tester.tap(find.byType(InkWell).first);
    await tester.pumpAndSettle();

    // assert
    verify(mockNotifier.fetchTvSeriesDetail(tId));
    verify(mockNotifier.loadWatchlistStatus(tId));
  });

  testWidgets('Back button should navigate back when pressed',
      (WidgetTester tester) async {
    // arrange
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(tTvSeriesDetail);
    when(mockNotifier.tvSeriesRecommendations)
        .thenReturn(<TvSeries>[tTvSeries]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    // act
    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    // assert
    expect(find.byType(TvSeriesDetailPage), findsNothing);
  });

  testWidgets('DetailContent should correctly display formatted genres',
      (WidgetTester tester) async {
    // arrange
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(tTvSeriesDetail);
    when(mockNotifier.tvSeriesRecommendations)
        .thenReturn(<TvSeries>[tTvSeries]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    // act
    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));

    // assert
    expect(find.text('Action, Drama'), findsOneWidget);
  });

  testWidgets('DetailContent should handle empty genres',
      (WidgetTester tester) async {
    // arrange
    final emptyGenreTvSeriesDetail = TvSeriesDetail(
      backdropPath: 'path/to/backdrop.jpg',
      episodeRunTime: [60],
      firstAirDate: '2023-01-01',
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
      voteCount: 100,
      genres: [],
    );

    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(emptyGenreTvSeriesDetail);
    when(mockNotifier.tvSeriesRecommendations)
        .thenReturn(<TvSeries>[tTvSeries]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    // act
    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));

    // assert
    expect(find.text(''), findsNothing);
  });
}
