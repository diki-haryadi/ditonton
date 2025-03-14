import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_event.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_state.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([MovieListBloc])
void main() {
  late MockMovieListBloc mockBloc;

  setUp(() {
    mockBloc = MockMovieListBloc();
    when(mockBloc.state).thenReturn(MovieListState.initial());
    when(mockBloc.stream).thenAnswer((_) => Stream.fromIterable([MovieListState.initial()]));
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieListBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer((_) => Stream.fromIterable([
          MovieListState.initial().copyWith(
            popularMoviesState: RequestState.Loading,
          ),
        ]));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
    await tester.pump();

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer((_) => Stream.fromIterable([
          MovieListState.initial().copyWith(
            popularMoviesState: RequestState.Loaded,
            popularMovies: <Movie>[],
          ),
        ]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
    await tester.pump();

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer((_) => Stream.fromIterable([
          MovieListState.initial().copyWith(
            popularMoviesState: RequestState.Error,
            message: 'Error message',
          ),
        ]));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
    await tester.pump();

    expect(textFinder, findsOneWidget);
  });
}
