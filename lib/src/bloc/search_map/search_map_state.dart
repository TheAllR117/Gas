part of 'search_map_bloc.dart';

@immutable
class SearchState {
  final bool manualselection;

  SearchState({this.manualselection = false});

  SearchState copyWith({bool? manualselection}) =>
      SearchState(manualselection: manualselection ?? this.manualselection);
}
