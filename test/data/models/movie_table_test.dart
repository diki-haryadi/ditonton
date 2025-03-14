import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieTable = MovieTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieMap = {
    'id': 1,
    'title': 'title',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  final tWatchlistMovie = Movie.watchlist(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  test('should convert entity to map', () async {
    // act
    final result = tMovieTable.toJson();
    // assert
    expect(result, tMovieMap);
  });

  test('should convert from map to entity', () async {
    // act
    final result = MovieTable.fromMap(tMovieMap);
    // assert
    expect(result, tMovieTable);
  });

  test('should convert entity MovieDetail to MovieTable', () async {
    // act
    final result = MovieTable.fromEntity(tMovieDetail);
    // assert
    expect(result, tMovieTable);
  });

  test('should convert MovieTable to watchlist Movie entity', () async {
    // act
    final result = tMovieTable.toEntity();
    // assert
    expect(result, tWatchlistMovie);
  });
}
