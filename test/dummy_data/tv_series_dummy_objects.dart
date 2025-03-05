import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

final testTvSeries = TvSeries(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalName: 'Spider-Man: The Series',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2022-01-01',
    name: 'Spider-Man: The Series',
    voteAverage: 7.2,
    voteCount: 13507,
    originCountry: ['US'],
    originalLanguage: 'en');

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    episodeRunTime: [60],
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    homepage: 'https://example.com',
    inProduction: false,
    lastAirDate: 'lastAirDate',
    numberOfEpisodes: 12,
    numberOfSeasons: 2,
    originalLanguage: 'en',
    popularity: 8.5,
    status: 'Ended',
    tagline: 'Test tagline',
    type: 'Scripted');

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
  firstAirDate: 'firstAirDate',
);

final testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
