import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      Provider.of<TvSeriesListNotifier>(context, listen: false)
        ..fetchNowPlayingTvSeries()
        ..fetchPopularTvSeries()
        ..fetchTopRatedTvSeries();
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
              Consumer<TvSeriesListNotifier>(
                builder: (context, data, child) {
                  final state = data.nowPlayingState;
                  if (state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    return TvSeriesList(data.nowPlayingTvSeries);
                  } else if (state == RequestState.Error) {
                    return Center(
                      child: Text(data.message),
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
              Consumer<TvSeriesListNotifier>(
                builder: (context, data, child) {
                  final state = data.popularTvSeriesState;
                  if (state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    return TvSeriesList(data.popularTvSeries);
                  } else if (state == RequestState.Error) {
                    return Center(
                      child: Text(data.message),
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
              Consumer<TvSeriesListNotifier>(
                builder: (context, data, child) {
                  final state = data.topRatedTvSeriesState;
                  if (state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    return TvSeriesList(data.topRatedTvSeries);
                  } else if (state == RequestState.Error) {
                    return Center(
                      child: Text(data.message),
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
