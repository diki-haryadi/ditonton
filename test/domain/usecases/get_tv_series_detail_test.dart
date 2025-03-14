import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'get_tv_series_detail_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late MockGetTvSeriesDetail usecase;

  setUp(() {
    usecase = MockGetTvSeriesDetail();
  });

  final tId = 1;

  test('should get tv series detail from the repository', () async {
    // arrange
    when(usecase.execute(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvSeriesDetail));
  });
}