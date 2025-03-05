// Mocks generated by Mockito 5.4.5 from annotations
// in ditonton/test/domain/usecases/save_watchlist_tv_series_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:ditonton/common/failure.dart' as _i5;
import 'package:ditonton/domain/entities/tv_series.dart' as _i6;
import 'package:ditonton/domain/entities/tv_series_detail.dart' as _i7;
import 'package:ditonton/domain/repositories/tv_series_repository.dart' as _i3;
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

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [TvSeriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesRepository extends _i1.Mock
    implements _i3.TvSeriesRepository {
  MockTvSeriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>
      getNowPlayingTvSeries() => (super.noSuchMethod(
            Invocation.method(#getNowPlayingTvSeries, []),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.TvSeries>>(
                this,
                Invocation.method(#getNowPlayingTvSeries, []),
              ),
            ),
          ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>
      getPopularTvSeries() => (super.noSuchMethod(
            Invocation.method(#getPopularTvSeries, []),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.TvSeries>>(
                this,
                Invocation.method(#getPopularTvSeries, []),
              ),
            ),
          ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>
      getTopRatedTvSeries() => (super.noSuchMethod(
            Invocation.method(#getTopRatedTvSeries, []),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.TvSeries>>(
                this,
                Invocation.method(#getTopRatedTvSeries, []),
              ),
            ),
          ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.TvSeriesDetail>> getTvSeriesDetail(
    int? id,
  ) =>
      (super.noSuchMethod(
        Invocation.method(#getTvSeriesDetail, [id]),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i7.TvSeriesDetail>>.value(
          _FakeEither_0<_i5.Failure, _i7.TvSeriesDetail>(
            this,
            Invocation.method(#getTvSeriesDetail, [id]),
          ),
        ),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i7.TvSeriesDetail>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>
      getTvSeriesRecommendations(int? id) => (super.noSuchMethod(
            Invocation.method(#getTvSeriesRecommendations, [id]),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.TvSeries>>(
                this,
                Invocation.method(#getTvSeriesRecommendations, [id]),
              ),
            ),
          ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>> searchTvSeries(
    String? query,
  ) =>
      (super.noSuchMethod(
        Invocation.method(#searchTvSeries, [query]),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>.value(
          _FakeEither_0<_i5.Failure, List<_i6.TvSeries>>(
            this,
            Invocation.method(#searchTvSeries, [query]),
          ),
        ),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> saveWatchlist(
    _i7.TvSeriesDetail? tvSeries,
  ) =>
      (super.noSuchMethod(
        Invocation.method(#saveWatchlist, [tvSeries]),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
          _FakeEither_0<_i5.Failure, String>(
            this,
            Invocation.method(#saveWatchlist, [tvSeries]),
          ),
        ),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> removeWatchlist(
    _i7.TvSeriesDetail? tvSeries,
  ) =>
      (super.noSuchMethod(
        Invocation.method(#removeWatchlist, [tvSeries]),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
          _FakeEither_0<_i5.Failure, String>(
            this,
            Invocation.method(#removeWatchlist, [tvSeries]),
          ),
        ),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);

  @override
  _i4.Future<bool> isAddedToWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(#isAddedToWatchlist, [id]),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>
      getWatchlistTvSeries() => (super.noSuchMethod(
            Invocation.method(#getWatchlistTvSeries, []),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.TvSeries>>(
                this,
                Invocation.method(#getWatchlistTvSeries, []),
              ),
            ),
          ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>);
}
