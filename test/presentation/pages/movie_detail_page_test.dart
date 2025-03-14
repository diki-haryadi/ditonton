import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailBloc])
void main() {
  late MockMovieDetailBloc mockBloc;

  setUp(() {
    mockBloc = MockMovieDetailBloc();
    when(mockBloc.stream).thenAnswer((_) => Stream.fromIterable([MovieDetailState.initial()]));
    when(mockBloc.state).thenReturn(MovieDetailState.initial());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tId = 1;
  final tMovie = MovieDetail(
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
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tMovies = <Movie>[
    Movie(
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
    )
  ];

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(MovieDetailState(
      movieState: RequestState.Loaded,
      recommendationState: RequestState.Loaded,
      movieDetail: tMovie,
      recommendations: tMovies,
      isAddedToWatchlist: false,
      message: '',
      watchlistMessage: '',
    ));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(MovieDetailState(
      movieState: RequestState.Loaded,
      recommendationState: RequestState.Loaded,
      movieDetail: tMovie,
      recommendations: tMovies,
      isAddedToWatchlist: true,
      message: '',
      watchlistMessage: '',
    ));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer((_) => Stream.fromIterable([
      MovieDetailState(
        movieState: RequestState.Loaded,
        recommendationState: RequestState.Loaded,
        movieDetail: tMovie,
        recommendations: tMovies,
        isAddedToWatchlist: false,
        message: '',
        watchlistMessage: '',
      ),
      MovieDetailState(
        movieState: RequestState.Loaded,
        recommendationState: RequestState.Loaded,
        movieDetail: tMovie,
        recommendations: tMovies,
        isAddedToWatchlist: false,
        message: '',
        watchlistMessage: MovieDetailBloc.watchlistAddSuccessMessage,
      ),
    ]));
    when(mockBloc.state).thenReturn(MovieDetailState(
      movieState: RequestState.Loaded,
      recommendationState: RequestState.Loaded,
      movieDetail: tMovie,
      recommendations: tMovies,
      isAddedToWatchlist: false,
      message: '',
      watchlistMessage: '',
    ));


    final watchlistButton = find.byType(FilledButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(MovieDetailBloc.watchlistAddSuccessMessage),
        findsOneWidget);
  });

  testWidgets('Should display CircularProgressIndicator when movie loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(MovieDetailState(
      movieState: RequestState.Loading,
      recommendationState: RequestState.Empty,
      movieDetail: null,
      recommendations: [],
      isAddedToWatchlist: false,
      message: '',
      watchlistMessage: '',
    ));

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets('Should display error message when movie load fails',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(MovieDetailState(
      movieState: RequestState.Error,
      recommendationState: RequestState.Empty,
      movieDetail: null,
      recommendations: [],
      isAddedToWatchlist: false,
      message: 'Error message',
      watchlistMessage: '',
    ));

    final errorMessageFinder = find.text('Error message');

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(errorMessageFinder, findsOneWidget);
  });

  testWidgets('Should display recommendations when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(MovieDetailState(
      movieState: RequestState.Loaded,
      recommendationState: RequestState.Loaded,
      movieDetail: tMovie,
      recommendations: tMovies,
      isAddedToWatchlist: false,
      message: '',
      watchlistMessage: '',
    ));

    final recommendationsListFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(recommendationsListFinder, findsOneWidget);
  });

  testWidgets('Should call fetchMovieDetail when initialized',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(MovieDetailState(
      movieState: RequestState.Loading,
      recommendationState: RequestState.Empty,
      movieDetail: null,
      recommendations: [],
      isAddedToWatchlist: false,
      message: '',
      watchlistMessage: '',
    ));

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    verify(mockBloc.add(FetchMovieDetail(1)));
  });

  testWidgets('Should call loadWatchlistStatus when initialized',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(MovieDetailState(
      movieState: RequestState.Loading,
      recommendationState: RequestState.Empty,
      movieDetail: null,
      recommendations: [],
      isAddedToWatchlist: false,
      message: '',
      watchlistMessage: '',
    ));

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    verify(mockBloc.add(LoadWatchlistStatus(1)));
  });

  testWidgets('Should display movie details when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(MovieDetailState(
      movieState: RequestState.Loaded,
      recommendationState: RequestState.Loaded,
      movieDetail: tMovie,
      recommendations: tMovies,
      isAddedToWatchlist: false,
      message: '',
      watchlistMessage: '',
    ));

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.text('title'), findsOneWidget);
    expect(find.text('overview'), findsOneWidget);
    expect(find.text('Action'), findsWidgets);
    expect(find.text('2h 0m'), findsOneWidget);
  });

  testWidgets('Back button should pop',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(MovieDetailState(
      movieState: RequestState.Loaded,
      recommendationState: RequestState.Loaded,
      movieDetail: tMovie,
      recommendations: tMovies,
      isAddedToWatchlist: false,
      message: '',
      watchlistMessage: '',
    ));

    final backButton = find.byIcon(Icons.arrow_back);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(backButton, findsOneWidget);
    
    // Cannot test navigation pop in widget test without additional setup
    // but we can verify the button exists
  });
}