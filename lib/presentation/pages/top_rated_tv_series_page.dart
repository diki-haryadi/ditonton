import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_event.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_state.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv-series';

  @override
  _TopRatedTvSeriesPageState createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TvSeriesListBloc>().add(FetchTopRatedTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
          builder: (context, state) {
            if (state.topRatedTvSeriesState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.topRatedTvSeriesState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = state.topRatedTvSeries[index];
                  return TvSeriesCard(series);
                },
                itemCount: state.topRatedTvSeries.length,
              );
            } else if (state.topRatedTvSeriesState == RequestState.Error) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
