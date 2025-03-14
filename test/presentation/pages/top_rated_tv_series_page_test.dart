import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_event.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_state.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTvSeriesListBloc extends MockBloc<TvSeriesListEvent, TvSeriesListState> implements TvSeriesListBloc {}

void main() {
  late MockTvSeriesListBloc mockBloc;

  setUp(() {
    mockBloc = MockTvSeriesListBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesListBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvSeriesListState.initial().copyWith(
      topRatedTvSeriesState: RequestState.Loading,
    ));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvSeriesListState.initial().copyWith(
      topRatedTvSeriesState: RequestState.Loaded,
      topRatedTvSeries: <TvSeries>[],
    ));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvSeriesListState.initial().copyWith(
      topRatedTvSeriesState: RequestState.Error,
      message: 'Error message',
    ));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
