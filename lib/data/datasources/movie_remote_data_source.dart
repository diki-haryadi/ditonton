import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/config.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:http/http.dart' as http;

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    try {
      final url = AppConfig.getNowPlayingMoviesUrl();

      // Menggunakan custom get method dengan retry
      final response = await _getWithRetry(url);

      if (response.statusCode == 200) {
        return MovieResponse.fromJson(json.decode(response.body)).movieList;
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw ConnectionFailureException('Failed to connect to the network');
    } on http.ClientException {
      throw ConnectionFailureException('Failed to connect to the server');
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    try {
      final url = AppConfig.getMovieDetailUrl(id);
      final response = await _getWithRetry(url);

      if (response.statusCode == 200) {
        return MovieDetailResponse.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw ConnectionFailureException('Failed to connect to the network');
    } on http.ClientException {
      throw ConnectionFailureException('Failed to connect to the server');
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    try {
      final url = AppConfig.getMovieRecommendationsUrl(id);
      final response = await _getWithRetry(url);

      if (response.statusCode == 200) {
        return MovieResponse.fromJson(json.decode(response.body)).movieList;
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw ConnectionFailureException('Failed to connect to the network');
    } on http.ClientException {
      throw ConnectionFailureException('Failed to connect to the server');
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final url = AppConfig.getPopularMoviesUrl();
      final response = await _getWithRetry(url);

      if (response.statusCode == 200) {
        return MovieResponse.fromJson(json.decode(response.body)).movieList;
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw ConnectionFailureException('Failed to connect to the network');
    } on http.ClientException {
      throw ConnectionFailureException('Failed to connect to the server');
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    try {
      final url = AppConfig.getTopRatedMoviesUrl();
      final response = await _getWithRetry(url);

      if (response.statusCode == 200) {
        return MovieResponse.fromJson(json.decode(response.body)).movieList;
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw ConnectionFailureException('Failed to connect to the network');
    } on http.ClientException {
      throw ConnectionFailureException('Failed to connect to the server');
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final url = AppConfig.searchMoviesUrl(query);
      final response = await _getWithRetry(url);

      if (response.statusCode == 200) {
        return MovieResponse.fromJson(json.decode(response.body)).movieList;
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw ConnectionFailureException('Failed to connect to the network');
    } on http.ClientException {
      throw ConnectionFailureException('Failed to connect to the server');
    } catch (e) {
      throw ServerException();
    }
  }

  // Custom get method with retry logic
  Future<http.Response> _getWithRetry(String url, {int maxRetries = 3}) async {
    int retries = 0;

    while (retries < maxRetries) {
      try {
        final response = await client.get(Uri.parse(url));
        return response;
      } catch (e) {
        retries++;
        if (retries >= maxRetries) {
          rethrow;
        }
        await Future.delayed(Duration(seconds: 1));
      }
    }

    throw SocketException('Failed to connect after $maxRetries retries');
  }
}

// Custom exception for better error handling
class ConnectionFailureException implements Exception {
  final String message;

  ConnectionFailureException(this.message);
}
