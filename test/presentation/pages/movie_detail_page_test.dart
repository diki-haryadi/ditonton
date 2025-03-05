import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailNotifier])
void main() {
  late MockMovieDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tId = 1;

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  testWidgets('should display center progress bar when movie detail is loading',
      (WidgetTester tester) async {
    // arrange
    when(mockNotifier.movieState).thenReturn(RequestState.Loading);

    // act
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(DetailContent), findsNothing);
  });

  testWidgets('should display DetailContent when movie detail data is loaded',
      (WidgetTester tester) async {
    // arrange
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(tMovieDetail);
    when(mockNotifier.movieRecommendations).thenReturn(tMovieList);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    // act
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

    // assert
    expect(find.byType(DetailContent), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets(
      'should display text error message when movie detail data failed to load',
      (WidgetTester tester) async {
    // arrange
    when(mockNotifier.movieState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    // act
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

    // assert
    expect(find.text('Error message'), findsOneWidget);
    expect(find.byType(DetailContent), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets(
      'should call fetchMovieDetail and loadWatchlistStatus when initialized',
      (WidgetTester tester) async {
    // arrange
    when(mockNotifier.movieState).thenReturn(RequestState.Loading);

    // act
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

    // assert
    verify(mockNotifier.fetchMovieDetail(tId));
    verify(mockNotifier.loadWatchlistStatus(tId));
  });
}
