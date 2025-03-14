import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'remove_watchlist_test.mocks.dart';

@GenerateMocks([RemoveWatchlist])
void main() {
  late MockRemoveWatchlist usecase;

  setUp(() {
    usecase = MockRemoveWatchlist();
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(usecase.execute(testMovieDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(usecase.execute(testMovieDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}