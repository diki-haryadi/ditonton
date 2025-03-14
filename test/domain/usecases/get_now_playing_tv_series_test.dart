import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_series_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetNowPlayingTvSeries(mockTvSeriesRepository);
  });

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getNowPlayingTvSeries())
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvSeriesList));
    verify(mockTvSeriesRepository.getNowPlayingTvSeries());
    verifyNoMoreInteractions(mockTvSeriesRepository);
  });
}
