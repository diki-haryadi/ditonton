class AppConfig {
  // API Configuration
  static const String apiKey = '2174d146bb9c0eab47529b2e77d6b526';
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';

  // Endpoints
  static String getNowPlayingMoviesUrl() =>
      '$baseUrl/movie/now_playing?api_key=$apiKey';
  static String getPopularMoviesUrl() =>
      '$baseUrl/movie/popular?api_key=$apiKey';
  static String getTopRatedMoviesUrl() =>
      '$baseUrl/movie/top_rated?api_key=$apiKey';
  static String getMovieDetailUrl(int id) =>
      '$baseUrl/movie/$id?api_key=$apiKey';
  static String getMovieRecommendationsUrl(int id) =>
      '$baseUrl/movie/$id/recommendations?api_key=$apiKey';
  static String searchMoviesUrl(String query) =>
      '$baseUrl/search/movie?api_key=$apiKey&query=$query';

  // TV Series Endpoints
  static String getNowPlayingTvSeriesUrl() =>
      '$baseUrl/tv/on_the_air?api_key=$apiKey';
  static String getPopularTvSeriesUrl() =>
      '$baseUrl/tv/popular?api_key=$apiKey';
  static String getTopRatedTvSeriesUrl() =>
      '$baseUrl/tv/top_rated?api_key=$apiKey';
  static String getTvSeriesDetailUrl(int id) =>
      '$baseUrl/tv/$id?api_key=$apiKey';
  static String getTvSeriesRecommendationsUrl(int id) =>
      '$baseUrl/tv/$id/recommendations?api_key=$apiKey';
  static String searchTvSeriesUrl(String query) =>
      '$baseUrl/search/tv?api_key=$apiKey&query=$query';
}
