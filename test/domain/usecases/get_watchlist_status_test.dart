import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatus usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchListStatus(mockMovieRepository);
  });

  final tId = 1;

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockMovieRepository.isAddedToWatchlist(tId))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, true);
    verify(mockMovieRepository.isAddedToWatchlist(tId));
    verifyNoMoreInteractions(mockMovieRepository);
  });

  test('should get watchlist status false from repository', () async {
    // arrange
    when(mockMovieRepository.isAddedToWatchlist(tId))
        .thenAnswer((_) async => false);
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, false);
    verify(mockMovieRepository.isAddedToWatchlist(tId));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
