import 'package:equatable/equatable.dart';

abstract class TvSeriesSearchEvent extends Equatable {
  const TvSeriesSearchEvent();

  @override
  List<Object> get props => [];
}

class QueryChanged extends TvSeriesSearchEvent {
  final String query;

  const QueryChanged(this.query);

  @override
  List<Object> get props => [query];
}



