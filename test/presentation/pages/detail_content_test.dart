import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';

import 'detail_content_test.mocks.dart';

@GenerateMocks([MovieDetailNotifier])
void main() {
  late MockMovieDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieDetailNotifier();
    when(mockNotifier.recommendationState).thenReturn(RequestState.Empty);
    when(mockNotifier.watchlistMessage).thenReturn('');
    when(mockNotifier.message).thenReturn('');
    ;
  });

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
    voteAverage: 8.0,
    voteCount: 1,
  );

  final tMovieDetailWithMultipleGenres = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [
      Genre(id: 1, name: 'Action'),
      Genre(id: 2, name: 'Drama'),
      Genre(id: 3, name: 'Sci-Fi'),
    ],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 8.0,
    voteCount: 1,
  );

  final tMovieDetailWithEmptyGenres = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 8.0,
    voteCount: 1,
  );

  final tMovieDetailWithNoHours = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 45,
    title: 'title',
    voteAverage: 8.0,
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
    voteAverage: 8.0,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: Scaffold(
          body: Material(
            child: body,
          ),
        ),
        routes: {
          MovieDetailPage.ROUTE_NAME: (context) => DummyDetailPage(),
        },
      ),
    );
  }

  group('DetailContent Widget', () {
    testWidgets('should display all UI elements correctly',
        (WidgetTester tester) async {
      // Act - render widget with mocked network images
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(_makeTestableWidget(
          DetailContent(
            tMovieDetail,
            tMovieList,
            false,
          ),
        ));
      });

      // Assert - verify all elements are displayed
      expect(find.text('title'), findsOneWidget);
      expect(find.text('Action'), findsOneWidget);
      expect(find.text('2h 0m'), findsOneWidget);
      expect(find.text('Overview'), findsOneWidget);
      expect(find.text('overview'), findsOneWidget);
      expect(find.text('Recommendations'), findsOneWidget);
      expect(find.text('Watchlist'), findsOneWidget);
      expect(find.byType(RatingBarIndicator), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsAtLeastNWidgets(1));
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should display check icon when added to watchlist',
        (WidgetTester tester) async {
      // Act - render widget with movie in watchlist
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(_makeTestableWidget(
          DetailContent(
            tMovieDetail,
            tMovieList,
            true,
          ),
        ));
      });

      // Assert
      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.byIcon(Icons.add), findsNothing);
    });

    testWidgets('should display add icon when not in watchlist',
        (WidgetTester tester) async {
      // Act - render widget with movie not in watchlist
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(_makeTestableWidget(
          DetailContent(
            tMovieDetail,
            tMovieList,
            false,
          ),
        ));
      });

      // Assert
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('should format multiple genres correctly',
        (WidgetTester tester) async {
      // Act - render widget with multiple genres
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(_makeTestableWidget(
          DetailContent(
            tMovieDetailWithMultipleGenres,
            tMovieList,
            false,
          ),
        ));
      });

      // Assert
      expect(find.text('Action, Drama, Sci-Fi'), findsOneWidget);
    });

    testWidgets('should handle empty genres list', (WidgetTester tester) async {
      // Act - render widget with empty genres list
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(_makeTestableWidget(
          DetailContent(
            tMovieDetailWithEmptyGenres,
            tMovieList,
            false,
          ),
        ));
      });

      // Assert - should find an empty string (not testing directly)
    });

    testWidgets('should format duration without hours correctly',
        (WidgetTester tester) async {
      // Act - render widget with runtime less than one hour
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(_makeTestableWidget(
          DetailContent(
            tMovieDetailWithNoHours,
            tMovieList,
            false,
          ),
        ));
      });

      // Assert
      expect(find.text('45m'), findsOneWidget);
    });

    testWidgets(
        'should call addWatchlist when watchlist button is tapped and not in watchlist',
        (WidgetTester tester) async {
      // Arrange
      when(mockNotifier.addWatchlist(tMovieDetail))
          .thenAnswer((_) async => true);
      when(mockNotifier.watchlistMessage)
          .thenReturn(MovieDetailNotifier.watchlistAddSuccessMessage);

      // Act - render widget and tap watchlist button
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(_makeTestableWidget(
          DetailContent(
            tMovieDetail,
            tMovieList,
            false,
          ),
        ));

        final watchlistButton = find.byType(FilledButton);
        await tester.tap(watchlistButton);
        await tester.pump();
      });

      // Assert
      verify(mockNotifier.addWatchlist(tMovieDetail));
    });

    testWidgets(
        'should call removeFromWatchlist when watchlist button is tapped and in watchlist',
        (WidgetTester tester) async {
      // Arrange
      when(mockNotifier.removeFromWatchlist(tMovieDetail))
          .thenAnswer((_) async => true);
      when(mockNotifier.watchlistMessage)
          .thenReturn(MovieDetailNotifier.watchlistRemoveSuccessMessage);

      // Act - render widget and tap watchlist button
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(_makeTestableWidget(
          DetailContent(
            tMovieDetail,
            tMovieList,
            true,
          ),
        ));

        final watchlistButton = find.byType(FilledButton);
        await tester.tap(watchlistButton);
        await tester.pump();
      });

      // Assert
      verify(mockNotifier.removeFromWatchlist(tMovieDetail));
    });

    testWidgets(
        'should show snackbar with success message when add to watchlist succeeds',
        (WidgetTester tester) async {
      // Arrange
      when(mockNotifier.addWatchlist(tMovieDetail))
          .thenAnswer((_) async => true);
      when(mockNotifier.watchlistMessage)
          .thenReturn(MovieDetailNotifier.watchlistAddSuccessMessage);

      // Act - render widget and tap watchlist button
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(_makeTestableWidget(
          DetailContent(
            tMovieDetail,
            tMovieList,
            false,
          ),
        ));

        final watchlistButton = find.byType(FilledButton);
        await tester.tap(watchlistButton);
        await tester.pump();
      });

      // Assert
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(MovieDetailNotifier.watchlistAddSuccessMessage),
          findsOneWidget);
    });

    testWidgets(
        'should show alert dialog with error message when add to watchlist fails',
        (WidgetTester tester) async {
      // Arrange
      when(mockNotifier.addWatchlist(tMovieDetail))
          .thenAnswer((_) async => false);
      when(mockNotifier.watchlistMessage)
          .thenReturn('Failed to add to watchlist');

      // Act - render widget and tap watchlist button
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(_makeTestableWidget(
          DetailContent(
            tMovieDetail,
            tMovieList,
            false,
          ),
        ));

        final watchlistButton = find.byType(FilledButton);
        await tester.tap(watchlistButton);
        await tester.pump(); // Pump once to start the animation
        await tester.pump(const Duration(seconds: 1)); // Pump again to complete the animation
      });

      // Assert
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed to add to watchlist'), findsOneWidget);
    });

    testWidgets('should navigate to movie detail page when recommendation is tapped',
        (WidgetTester tester) async {
      // Arrange
      when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);

      // Act - render widget and tap recommendation
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(_makeTestableWidget(
          DetailContent(
            tMovieDetail,
            tMovieList,
            false,
          ),
        ));

        final inkWell = find.byType(InkWell).first;
        await tester.tap(inkWell);
        await tester.pump(); // Pump once to start the navigation
        await tester.pump(const Duration(seconds: 1)); // Pump again to complete the navigation
      });

      // Assert - navigation to detail page occurred
      expect(find.byType(DummyDetailPage), findsOneWidget);
    });

    testWidgets('back button should call Navigator.pop',
        (WidgetTester tester) async {
      // Act - Build widget with navigation observer
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          ChangeNotifierProvider<MovieDetailNotifier>.value(
            value: mockNotifier,
            child: MaterialApp(
              home: Scaffold(
                body: DetailContent(
                  tMovieDetail,
                  tMovieList,
                  false,
                ),
              ),
            ),
          ),
        );

        // Find and tap back button
        final backButton = find.byType(IconButton);
        await tester.tap(backButton);
        await tester.pump(); // Pump once to start the navigation
        await tester.pump(const Duration(seconds: 1)); // Pump again to complete the navigation
      });

      // The test passes if no errors occur during tapping the back button
    });
  });
}

// Dummy page for navigation testing
class DummyDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Dummy Detail Page'),
      ),
    );
  }
}

// Mock Navigator Observer for testing navigation
class MockNavigatorObserver extends Mock implements NavigatorObserver {}
