import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart'; // Add this import
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'get_watchlist_tv_series_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late MockGetWatchlistTvSeries usecase;

  setUp(() {
    usecase = MockGetWatchlistTvSeries();
  });

  // test('should get list of tv series from the repository', () async {
  //   // arrange
  //   when(usecase.execute())
  //       .thenAnswer((_) async => Right<Failure, List<TvSeries>>([testWatchlistTvSeries]));
  //   // act
  //   final result = await usecase.execute();
  //   // assert
  //   expect(result, equals(Right<Failure, List<TvSeries>>([testWatchlistTvSeries])));
  // });
}