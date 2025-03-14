import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_watchlist_status_tv_series_test.mocks.dart';

@GenerateMocks([GetWatchListStatusTvSeries])
void main() {
  late MockGetWatchListStatusTvSeries usecase;

  setUp(() {
    usecase = MockGetWatchListStatusTvSeries();
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(usecase.execute(1)).thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}