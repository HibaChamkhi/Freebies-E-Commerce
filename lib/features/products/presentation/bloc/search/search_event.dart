part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class GetSearchValueEvent extends SearchEvent {}

class DeleteSearchValueEvent extends SearchEvent {
  final int id;

  const DeleteSearchValueEvent({required this.id});
}

class SetSearchValueEvent extends SearchEvent {
  final SearchModel searchValue;

  const SetSearchValueEvent({required this.searchValue});
}

class SearchProductEvent extends SearchEvent {
  final String query ;
  const SearchProductEvent({required this.query,});

  @override
  List<Object?> get props => [query];
}