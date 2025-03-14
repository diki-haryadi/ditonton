import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'Original Title',
    overview: 'Overview',
    popularity: 1000.0,
    posterPath: '/path.jpg',
    releaseDate: '2022-01-01',
    title: 'Title',
    video: false,
    voteAverage: 8.0,
    voteCount: 200,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'Original Title',
    overview: 'Overview',
    popularity: 1000.0,
    posterPath: '/path.jpg',
    releaseDate: '2022-01-01',
    title: 'Title',
    video: false,
    voteAverage: 8.0,
    voteCount: 200,
  );

  test('should be a subclass of Movie entity', () {
    final result = tMovieModel.toEntity();
    expect(result, tMovie);
  });

  test('should convert from JSON', () {
    // arrange
    final Map<String, dynamic> jsonMap = {
      'adult': false,
      'backdrop_path': '/path.jpg',
      'genre_ids': [1, 2, 3],
      'id': 1,
      'original_title': 'Original Title',
      'overview': 'Overview',
      'popularity': 1000.0,
      'poster_path': '/path.jpg',
      'release_date': '2022-01-01',
      'title': 'Title',
      'video': false,
      'vote_average': 8.0,
      'vote_count': 200,
    };
    // act
    final result = MovieModel.fromJson(jsonMap);
    // assert
    expect(result, tMovieModel);
  });

  test('should convert to JSON', () {
    // act
    final result = tMovieModel.toJson();
    // assert
    final expectedJsonMap = {
      'adult': false,
      'backdrop_path': '/path.jpg',
      'genre_ids': [1, 2, 3],
      'id': 1,
      'original_title': 'Original Title',
      'overview': 'Overview',
      'popularity': 1000.0,
      'poster_path': '/path.jpg',
      'release_date': '2022-01-01',
      'title': 'Title',
      'video': false,
      'vote_average': 8.0,
      'vote_count': 200,
    };
    expect(result, expectedJsonMap);
  });
}