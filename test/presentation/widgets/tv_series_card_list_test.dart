import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testTvSeries = TvSeries(
    backdropPath: '/backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/posterPath',
    firstAirDate: '2022-01-01',
    name: 'Name',
    voteAverage: 1.0,
    voteCount: 1,
    originCountry: ['US'],
    originalLanguage: 'en',
  );

  group('TvSeriesCard Widget', () {
    Widget _makeTestableWidget(Widget body) {
      return MaterialApp(
        home: Scaffold(
          body: body,
        ),
      );
    }

    testWidgets('should display tv series information correctly',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(_makeTestableWidget(TvSeriesCard(testTvSeries)));

      // Act & Assert
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Overview'), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('should navigate to tv series detail page when tapped',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: TvSeriesCard(testTvSeries)),
        routes: {
          TvSeriesDetailPage.ROUTE_NAME: (context) => Container(),
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
      await tester.pumpWidget(_makeTestableWidget(TvSeriesCard(testTvSeries)));

      // Act & Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should handle null values gracefully',
        (WidgetTester tester) async {
      // Arrange
      final tvSeriesWithNulls = TvSeries(
        backdropPath: null,
        genreIds: [1, 2, 3],
        id: 1,
        originalName: 'Original Name',
        overview: null,
        popularity: 1.0,
        posterPath: null,
        firstAirDate: null,
        name: null,
        voteAverage: 1.0,
        voteCount: 1,
        originCountry: ['US'],
        originalLanguage: 'en',
      );

      await tester.pumpWidget(_makeTestableWidget(TvSeriesCard(tvSeriesWithNulls)));

      // Act & Assert
      expect(find.text('-'), findsNWidgets(2)); // For both name and overview
    });
  });
}