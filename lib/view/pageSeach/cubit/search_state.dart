part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchInitialSuccess extends SearchState {}

class SearchInitialSuccessNoData extends SearchState {}

class SearchInitialLoading extends SearchState {}

class SearchInitialError extends SearchState {}
