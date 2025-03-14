import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_event.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_state.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieListBloc extends MockBloc<MovieListEvent, MovieListState>
    implements MovieListBloc {}

class FakeMovieListEvent extends Fake implements MovieListEvent {}

class FakeMovieListState extends Fake implements MovieListState {}

void main() {
  late MockMovieListBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakeMovieListEvent());
    registerFallbackValue(FakeMovieListState());
  });

  setUp(() {
    mockBloc = MockMovieListBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieListBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieListState.initial().copyWith(
      topRatedMoviesState: RequestState.Loading,
    ));

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieListState.initial().copyWith(
      topRatedMoviesState: RequestState.Loaded,
      topRatedMovies: <Movie>[],
    ));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieListState.initial().copyWith(
      topRatedMoviesState: RequestState.Error,
      message: 'Error message',
    ));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
