import 'package:equatable/equatable.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class QueryChanged extends MovieSearchEvent {
  final String query;

  const QueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
