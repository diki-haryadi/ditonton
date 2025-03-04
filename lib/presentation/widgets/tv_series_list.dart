import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  TvSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final series = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: series.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${series.posterPath}',
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
