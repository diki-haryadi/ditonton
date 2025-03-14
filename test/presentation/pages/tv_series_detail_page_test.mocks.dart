// Mocks generated by Mockito 5.4.5 from annotations
// in ditonton/test/presentation/pages/tv_series_detail_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;

import 'package:bloc/bloc.dart' as _i11;
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart' as _i2;
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart'
    as _i3;
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart'
    as _i4;
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart'
    as _i6;
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart' as _i5;
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart'
    as _i8;
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_event.dart'
    as _i10;
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_state.dart'
    as _i7;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetTvSeriesDetail_0 extends _i1.SmartFake
    implements _i2.GetTvSeriesDetail {
  _FakeGetTvSeriesDetail_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeGetTvSeriesRecommendations_1 extends _i1.SmartFake
    implements _i3.GetTvSeriesRecommendations {
  _FakeGetTvSeriesRecommendations_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeGetWatchListStatusTvSeries_2 extends _i1.SmartFake
    implements _i4.GetWatchListStatusTvSeries {
  _FakeGetWatchListStatusTvSeries_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeSaveWatchlistTvSeries_3 extends _i1.SmartFake
    implements _i5.SaveWatchlistTvSeries {
  _FakeSaveWatchlistTvSeries_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeRemoveWatchlistTvSeries_4 extends _i1.SmartFake
    implements _i6.RemoveWatchlistTvSeries {
  _FakeRemoveWatchlistTvSeries_4(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeTvSeriesDetailState_5 extends _i1.SmartFake
    implements _i7.TvSeriesDetailState {
  _FakeTvSeriesDetailState_5(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [TvSeriesDetailBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesDetailBloc extends _i1.Mock
    implements _i8.TvSeriesDetailBloc {
  MockTvSeriesDetailBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTvSeriesDetail get getTvSeriesDetail => (super.noSuchMethod(
        Invocation.getter(#getTvSeriesDetail),
        returnValue: _FakeGetTvSeriesDetail_0(
          this,
          Invocation.getter(#getTvSeriesDetail),
        ),
      ) as _i2.GetTvSeriesDetail);

  @override
  _i3.GetTvSeriesRecommendations get getTvSeriesRecommendations =>
      (super.noSuchMethod(
        Invocation.getter(#getTvSeriesRecommendations),
        returnValue: _FakeGetTvSeriesRecommendations_1(
          this,
          Invocation.getter(#getTvSeriesRecommendations),
        ),
      ) as _i3.GetTvSeriesRecommendations);

  @override
  _i4.GetWatchListStatusTvSeries get getWatchListStatus => (super.noSuchMethod(
        Invocation.getter(#getWatchListStatus),
        returnValue: _FakeGetWatchListStatusTvSeries_2(
          this,
          Invocation.getter(#getWatchListStatus),
        ),
      ) as _i4.GetWatchListStatusTvSeries);

  @override
  _i5.SaveWatchlistTvSeries get saveWatchlist => (super.noSuchMethod(
        Invocation.getter(#saveWatchlist),
        returnValue: _FakeSaveWatchlistTvSeries_3(
          this,
          Invocation.getter(#saveWatchlist),
        ),
      ) as _i5.SaveWatchlistTvSeries);

  @override
  _i6.RemoveWatchlistTvSeries get removeWatchlist => (super.noSuchMethod(
        Invocation.getter(#removeWatchlist),
        returnValue: _FakeRemoveWatchlistTvSeries_4(
          this,
          Invocation.getter(#removeWatchlist),
        ),
      ) as _i6.RemoveWatchlistTvSeries);

  @override
  _i7.TvSeriesDetailState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeTvSeriesDetailState_5(
          this,
          Invocation.getter(#state),
        ),
      ) as _i7.TvSeriesDetailState);

  @override
  _i9.Stream<_i7.TvSeriesDetailState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i9.Stream<_i7.TvSeriesDetailState>.empty(),
      ) as _i9.Stream<_i7.TvSeriesDetailState>);

  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);

  @override
  void add(_i10.TvSeriesDetailEvent? event) => super.noSuchMethod(
        Invocation.method(#add, [event]),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i10.TvSeriesDetailEvent? event) => super.noSuchMethod(
        Invocation.method(#onEvent, [event]),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i7.TvSeriesDetailState? state) => super.noSuchMethod(
        Invocation.method(#emit, [state]),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i10.TvSeriesDetailEvent>(
    _i11.EventHandler<E, _i7.TvSeriesDetailState>? handler, {
    _i11.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(#on, [handler], {#transformer: transformer}),
        returnValueForMissingStub: null,
      );

  @override
  void onTransition(
    _i11.Transition<_i10.TvSeriesDetailEvent, _i7.TvSeriesDetailState>?
        transition,
  ) =>
      super.noSuchMethod(
        Invocation.method(#onTransition, [transition]),
        returnValueForMissingStub: null,
      );

  @override
  _i9.Future<void> close() => (super.noSuchMethod(
        Invocation.method(#close, []),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  void onChange(_i11.Change<_i7.TvSeriesDetailState>? change) =>
      super.noSuchMethod(
        Invocation.method(#onChange, [change]),
        returnValueForMissingStub: null,
      );

  @override
  void addError(Object? error, [StackTrace? stackTrace]) => super.noSuchMethod(
        Invocation.method(#addError, [error, stackTrace]),
        returnValueForMissingStub: null,
      );

  @override
  void onError(Object? error, StackTrace? stackTrace) => super.noSuchMethod(
        Invocation.method(#onError, [error, stackTrace]),
        returnValueForMissingStub: null,
      );
}
