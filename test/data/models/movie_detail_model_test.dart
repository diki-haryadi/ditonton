import 'dart:convert';

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tMovieDetailModel = MovieDetailResponse(
    adult: false,
    backdropPath: "/path.jpg",
    budget: 100000000,
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: "https://example.com",
    id: 1,
    imdbId: "tt12345",
    originalLanguage: "en",
    originalTitle: "Original Title",
    overview: "Overview",
    popularity: 100.0,
    posterPath: "/path.jpg",
    releaseDate: "2022-01-01",
    revenue: 200000000,
    runtime: 120,
    status: "Released",
    tagline: "Tagline",
    title: "Title",
    video: false,
    voteAverage: 8.0,
    voteCount: 1000,
  );

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: "/path.jpg",
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: "Original Title",
    overview: "Overview",
    posterPath: "/path.jpg",
    releaseDate: "2022-01-01",
    runtime: 120,
    title: "Title",
    voteAverage: 8.0,
    voteCount: 1000,
  );

  test('should be a subclass of MovieDetail entity', () {
    final result = tMovieDetailModel.toEntity();
    expect(result, tMovieDetail);
  });

  test('should convert from JSON', () {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/movie_detail.json'));
    // act
    final result = MovieDetailResponse.fromJson(jsonMap);
    // assert
    expect(result, isA<MovieDetailResponse>());
  });

  test('should convert to JSON', () {
    // act
    final result = tMovieDetailModel.toJson();
    // assert
    final expectedJsonMap = {
      "adult": false,
      "backdrop_path": "/path.jpg",
      "budget": 100000000,
      "genres": [
        {
          "id": 1,
          "name": "Action"
        }
      ],
      "homepage": "https://example.com",
      "id": 1,
      "imdb_id": "tt12345",
      "original_language": "en",
      "original_title": "Original Title",
      "overview": "Overview",
      "popularity": 100.0,
      "poster_path": "/path.jpg",
      "release_date": "2022-01-01",
      "revenue": 200000000,
      "runtime": 120,
      "status": "Released",
      "tagline": "Tagline",
      "title": "Title",
      "video": false,
      "vote_average": 8.0,
      "vote_count": 1000,
    };
    expect(result, expectedJsonMap);
  });
}