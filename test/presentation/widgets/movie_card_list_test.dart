import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testMovie = Movie(
    adult: false,
    backdropPath: '/backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'Original Title',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/posterPath',
    releaseDate: 'releaseDate',
    title: 'Title',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('MovieCard Widget', () {
    Widget _makeTestableWidget(Widget body) {
      return MaterialApp(
        home: Scaffold(
          body: body,
        ),
      );
    }

    testWidgets('should display movie information correctly',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(_makeTestableWidget(MovieCard(testMovie)));

      // Act & Assert
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Overview'), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('should navigate to movie detail page when tapped',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: MovieCard(testMovie)),
        routes: {
          MovieDetailPage.ROUTE_NAME: (context) => Container(),
        },
      ));

      // Act
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should display placeholder when loading image',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(_makeTestableWidget(MovieCard(testMovie)));

      // Act & Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should handle null values gracefully',
        (WidgetTester tester) async {
      // Arrange
      final movieWithNulls = Movie(
        adult: false,
        backdropPath: null,
        genreIds: [1, 2, 3],
        id: 1,
        originalTitle: null,
        overview: null,
        popularity: 1.0,
        posterPath: null,
        releaseDate: null,
        title: null,
        video: false,
        voteAverage: 1.0,
        voteCount: 1,
      );

      await tester.pumpWidget(_makeTestableWidget(MovieCard(movieWithNulls)));

      // Act & Assert
      expect(find.text('-'), findsNWidgets(2)); // For both title and overview
    });
  });
}