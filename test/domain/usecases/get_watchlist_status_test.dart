import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_watchlist_status_test.mocks.dart';

@GenerateMocks([GetWatchListStatus])
void main() {
  late MockGetWatchListStatus usecase;

  setUp(() {
    usecase = MockGetWatchListStatus();
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