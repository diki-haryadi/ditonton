import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_event.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_state.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-detail';

  final int id;
  TvSeriesDetailPage({required this.id});

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesDetailBloc>().add(FetchTvSeriesDetail(widget.id));
      context
          .read<TvSeriesDetailBloc>()
          .add(LoadTvSeriesWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TvSeriesDetailBloc, TvSeriesDetailState>(
        listenWhen: (previous, current) =>
            previous.watchlistMessage != current.watchlistMessage &&
            current.watchlistMessage.isNotEmpty,
        listener: (context, state) {
          final message = state.watchlistMessage;
          if (message == TvSeriesDetailBloc.watchlistAddSuccessMessage ||
              message == TvSeriesDetailBloc.watchlistRemoveSuccessMessage) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message)));
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(message),
                );
              },
            );
          }
        },
        builder: (context, state) {
          if (state.tvSeriesState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.tvSeriesState == RequestState.Loaded) {
            final series = state.tvSeriesDetail!;
            return SafeArea(
              child: DetailContent(
                series,
                state.recommendations,
                state.isAddedToWatchlist,
              ),
            );
          } else if (state.tvSeriesState == RequestState.Error) {
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail series;
  final List<TvSeries> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.series, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            CachedNetworkImage(
              imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
              width: double.infinity,
              height: 500,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Container(
              margin: const EdgeInsets.only(top: 48 + 8),
              height: MediaQuery.of(context).size.height,
              child: DraggableScrollableSheet(
                maxChildSize: 1.0,
                minChildSize: 0.25,
                initialChildSize: 0.5,
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    padding:
                        const EdgeInsets.only(left: 16, top: 16, right: 16),
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  series.name,
                                  style:
                                      kHeading5.copyWith(color: Colors.white),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kMikadoYellow,
                                    foregroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    if (!isAddedWatchlist) {
                                      context
                                          .read<TvSeriesDetailBloc>()
                                          .add(AddTvSeriesToWatchlist(series));
                                    } else {
                                      context.read<TvSeriesDetailBloc>().add(
                                          RemoveTvSeriesFromWatchlist(series));
                                    }
                                    // We no longer need to check state here as we're using BlocConsumer
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      isAddedWatchlist
                                          ? Icon(Icons.check,
                                              color: Colors.black)
                                          : Icon(Icons.add,
                                              color: Colors.black),
                                      Text('Watchlist'),
                                    ],
                                  ),
                                ),
                                Text(
                                  _showGenres(series.genres),
                                  style: TextStyle(color: Colors.white70),
                                ),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: series.voteAverage / 2,
                                      itemCount: 5,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: kMikadoYellow,
                                      ),
                                      itemSize: 24,
                                    ),
                                    Text('${series.voteAverage}')
                                  ],
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Overview',
                                  style:
                                      kHeading6.copyWith(color: Colors.white),
                                ),
                                Text(
                                  series.overview,
                                  style: TextStyle(color: Colors.white70),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Recommendations',
                                  style:
                                      kHeading6.copyWith(color: Colors.white),
                                ),
                                BlocBuilder<TvSeriesDetailBloc,
                                    TvSeriesDetailState>(
                                  builder: (context, state) {
                                    if (state.recommendationState ==
                                        RequestState.Loading) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state.recommendationState ==
                                        RequestState.Error) {
                                      return Text(state.message);
                                    } else if (state.recommendationState ==
                                        RequestState.Loaded) {
                                      return Container(
                                        height: 150,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final series =
                                                recommendations[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                    context,
                                                    TvSeriesDetailPage
                                                        .ROUTE_NAME,
                                                    arguments: series.id,
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        '$BASE_IMAGE_URL${series.posterPath}',
                                                    placeholder:
                                                        (context, url) =>
                                                            Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: recommendations.length,
                                        ),
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
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            color: Colors.white54,
                            height: 4,
                            width: 48,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black45,
                foregroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
