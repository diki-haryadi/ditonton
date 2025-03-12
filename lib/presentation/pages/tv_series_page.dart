import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_event.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_state.dart';
import 'package:ditonton/presentation/widgets/tv_series_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series';

  @override
  _TvSeriesPageState createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesListBloc>().add(FetchNowPlayingTvSeries());
      context.read<TvSeriesListBloc>().add(FetchPopularTvSeries());
      context.read<TvSeriesListBloc>().add(FetchTopRatedTvSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
                builder: (context, state) {
                  final nowPlayingState = state.nowPlayingState;
                  if (nowPlayingState == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (nowPlayingState == RequestState.Loaded) {
                    return TvSeriesList(state.nowPlayingTvSeries);
                  } else if (nowPlayingState == RequestState.Error) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(height: 16),
              Text(
                'Popular',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
                builder: (context, state) {
                  final popularTvSeriesState = state.popularTvSeriesState;
                  if (popularTvSeriesState == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (popularTvSeriesState == RequestState.Loaded) {
                    return TvSeriesList(state.popularTvSeries);
                  } else if (popularTvSeriesState == RequestState.Error) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(height: 16),
              Text(
                'Top Rated',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
                builder: (context, state) {
                  final topRatedTvSeriesState = state.topRatedTvSeriesState;
                  if (topRatedTvSeriesState == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (topRatedTvSeriesState == RequestState.Loaded) {
                    return TvSeriesList(state.topRatedTvSeries);
                  } else if (topRatedTvSeriesState == RequestState.Error) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}