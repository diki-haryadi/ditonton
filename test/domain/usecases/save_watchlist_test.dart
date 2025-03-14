import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'save_watchlist_test.mocks.dart';

@GenerateMocks([SaveWatchlist])
void main() {
  late MockSaveWatchlist usecase;

  setUp(() {
    usecase = MockSaveWatchlist();
  });

  test('should save movie to the repository', () async {
    // arrange
    when(usecase.execute(testMovieDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(usecase.execute(testMovieDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}