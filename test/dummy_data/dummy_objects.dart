import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';

// Movie dummy objects
final testMovie = Movie(
  adult: false,
  backdropPath: '/backdropPath',
  genreIds: [1, 2, 3],
  id: 1,
  originalTitle: 'Original Title',
  overview: 'Overview',
  popularity: 1.0,
  posterPath: '/posterPath',
  releaseDate: 'releaseDate',
  title: 'Title',
  video: false,
  voteAverage: 1.0,
  voteCount: 1,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'Original Title',
  overview: 'Overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'Title',
  voteAverage: 1.0,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'Title',
  posterPath: 'posterPath',
  overview: 'Overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'Title',
  posterPath: 'posterPath',
  overview: 'Overview',
);

final testMovieMap = {
  'id': 1,
  'title': 'Title',
  'posterPath': 'posterPath',
  'overview': 'Overview',
};

// TV Series dummy objects
final testTvSeries = TvSeries(
  backdropPath: '/backdropPath',
  firstAirDate: 'firstAirDate',
  genreIds: [1, 2, 3],
  id: 1,
  name: 'Name',
  originCountry: ['US'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: '/posterPath',
  voteAverage: 1.0,
  voteCount: 1,
);

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
  backdropPath: 'backdropPath',
  episodeRunTime: [60],
  firstAirDate: 'firstAirDate',
  genres: [Genre(id: 1, name: 'Action')],
  homepage: 'homepage',
  id: 1,
  inProduction: false,
  lastAirDate: 'lastAirDate',
  name: 'name',
  numberOfEpisodes: 12,
  numberOfSeasons: 1,
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: '/posterPath',
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 1.0,
  voteCount: 1,
);

final testWatchlistTvSeries = TvSeries(
  id: 1,
  name: 'name',
  posterPath: '/posterPath',
  overview: 'overview',
  backdropPath: null,
  firstAirDate: null,
  genreIds: const [],
  originCountry: const [],
  originalLanguage: '',
  originalName: '',
  popularity: 0,
  voteAverage: 0,
  voteCount: 0,
);

final testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: '/posterPath',
  overview: 'overview',
);

final testTvSeriesMap = {
  'id': 1,
  'name': 'name',
  'posterPath': '/posterPath',
  'overview': 'overview',
};
